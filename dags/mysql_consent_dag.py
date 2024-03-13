
from collections import defaultdict
import pendulum
from airflow.decorators import dag, task
import mysql.connector
from airflow.operators.python import get_current_context
import re
import json
import requests
import os

os.environ["no_proxy"] = "*"

URL = 'http://138.201.63.104:5010/submit'

# MySQL Server Connection Details
# host = 'your_mysql_host'
# user = 'your_username'
# password = 'your_password'
# database = 'your_database_name'

# SSL Certificates
# ssl_ca = 'path/to/ca-cert.pem'
# ssl_key = 'path/to/client-key.pem'
# ssl_cert = 'path/to/client-cert.pem'

def regex_match(values, regex_exp, match_threshold):
    try:
        regex = re.compile(regex_exp)
        values = [value for value in values if value is not None]
        matching_count = sum(1 for value in values if regex.match(str(value)))
        percentage_match = (matching_count / len(values)) * 100
        return percentage_match >= match_threshold
    except Exception as e:
        print(f"got exception for: {regex_exp} values: {values[:10]}")
        return False
    
@dag(
    'mysql_consent_dag',
    schedule=None,
    start_date=pendulum.datetime(2023, 3, 6, tz="UTC"),
    catchup=False,
    tags=["example"],
)
def mysql_consent_dag():
        
    @task()
    def fetch_tables(**kwargs):
        dag_run_conf = kwargs['dag_run'].conf
        print(f"DAG configuration: {dag_run_conf}")
        
        try:
            # Establish a connection to the MySQL server
            connection = mysql.connector.connect(**kwargs['dag_run'].conf["data_source"]["creds"])

            # Create a cursor object to execute SQL queries
            cursor = connection.cursor()

            # Execute the query to get the list of tables
            cursor.execute("SHOW TABLES")

            # Fetch all tables from the cursor
            tables = [table[0] for table in cursor.fetchall()]
            
            print(tables)
            
            return tables
        
        except mysql.connector.Error as err:
            print(f"Error: {err}")

    @task
    def consumer(table):
        context = get_current_context()
        print(context['params'])
        print(f'executing analyzers on {table}')
        match_threshold = context['params']["match_threshold"]
        max_rows = context['params']["max_rows"]
        
        try:
            # Establish a connection to the MySQL server
            connection = mysql.connector.connect(**context['params']["data_source"]["creds"])

            # Create a cursor object to execute SQL queries
            cursor = connection.cursor()

            # Execute the query to get the list of tables
            cursor.execute(f"SELECT * FROM {table} limit {max_rows}")
            column_names = [x[0] for x in cursor.description]
            column_map = defaultdict(list)

            for row in cursor.fetchall():
                for index, value in enumerate(row):
                    column_map[column_names[index]].append(value)
            
            print(column_map)  
            
            analyzers = context['params']['analyzers']
            output = defaultdict(list)
            
            for key, regex_exp in analyzers.items():
                print(f'analyzing {key} with regex: {regex_exp}')
                for column, records in column_map.items():
                    if regex_match(records, regex_exp, match_threshold):
                        output[key].append(column)
            
            print({'table': table, 'response': output })
            
            payload = json.dumps({'table': table, 'response': output })
            response = requests.request("POST", URL, headers = {'Content-Type': 'application/json'}, data = payload)
            print(response.text)
            
        except mysql.connector.Error as err:
            print(f"Error: {err}")
        
    consumer.expand(table=fetch_tables())

mysql_consent_dag_instance = mysql_consent_dag()