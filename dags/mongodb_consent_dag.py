from collections import defaultdict
import pendulum
from airflow.decorators import dag, task
from airflow.operators.python import get_current_context
import re
import json
import requests
import os
from pymongo import MongoClient

os.environ["no_proxy"] = "*"

URL = 'http://138.201.63.104:5010/submit'

# MongoDB Connection Details
# Replace these values with your MongoDB connection details


def regex_match(values, regex_exp, match_threshold):
    try:
        regex = re.compile(regex_exp)
        values = [value for value in values if value is not None]
        matching_count = sum(1 for value in values if regex.match(str(value)))
        percentage_match = (matching_count / len(values)) * 100
        return percentage_match >= match_threshold
    except Exception as e:
        print(f"got exception for: {regex_exp} values: {values}")
        return False

@dag(
    'mongodb_consent_dag',
    schedule=None,
    start_date=pendulum.datetime(2023, 3, 6, tz="UTC"),
    catchup=False,
    tags=["example"],
)
def mongodb_consent_dag():
    @task()
    def fetch_collections(**kwargs):
        dag_run_conf = kwargs['dag_run'].conf
        print(f"DAG configuration: {dag_run_conf}")
        connection_string = dag_run_conf['data_source']['connection_string']
        database = dag_run_conf['data_source']['database']
        
        try:
            # Establish a connection to MongoDB
            client = MongoClient(connection_string)
            db = client[database]

            # Fetch all collections from the database
            collections = db.list_collection_names()

            print(collections)

            return collections

        except Exception as e:
            print(f"Error: {e}")

    @task
    def consumer(collection):
        context = get_current_context()
        print(context['params'])
        print(f'executing analyzers on {collection}')
        match_threshold = context['params']["match_threshold"]
        max_documents = context['params']["max_documents"]
        
        
        connection_string = context['params']['data_source']['connection_string']
        database = context['params']['data_source']['database']
        
        
        try:
            # Establish a connection to MongoDB
            client = MongoClient(connection_string)
            db = client[database]

            # Fetch documents from the collection
            documents = list(db[collection].find().limit(max_documents))

            column_names = list(documents[0].keys()) if documents else []
            column_map = defaultdict(list)

            for document in documents:
                for column in column_names:
                    if column in document:
                        column_map[column].append(document[column])

            print(column_map)

            analyzers = context['params']['analyzers']
            output = defaultdict(list)

            for key, regex_exp in analyzers.items():
                print(f'analyzing {key} with regex: {regex_exp}')
                for column, records in column_map.items():
                    if regex_match(records, regex_exp, match_threshold):
                        output[key].append(column)

            print({'collection': collection, 'response': output})

            payload = json.dumps({'collection': collection, 'response': output})
            response = requests.request("POST", URL, headers={'Content-Type': 'application/json'}, data=payload)
            print(response.text)

        except Exception as e:
            print(f"Error: {e}")

    consumer.expand(collection=fetch_collections())

mongodb_consent_dag_instance = mongodb_consent_dag()
