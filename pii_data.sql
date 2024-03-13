CREATE TABLE accounts (
	user_id SERIAL NOT NULL, 
	bank_account_number VARCHAR(16), 
	credit_card_number VARCHAR(16), 
	customer_id VARCHAR(10), 
	pan_number VARCHAR(10), 
	credit_history_url VARCHAR(255), 
	account_balance NUMERIC(15, 2), 
	loan_amount NUMERIC(15, 2), 
	loan_approval_date DATE, 
	last_credit_card_payment_date DATE, 
	investment_portfolio_url VARCHAR(255), 
	favorite_color VARCHAR(20), 
	lucky_number INTEGER, 
	pet_name VARCHAR(50), 
	favorite_movie VARCHAR(100), 
	shoe_size DOUBLE PRECISION, 
	unread_emails_count INTEGER, 
	mood_rating INTEGER, 
	random_text TEXT, 
	secret_code VARCHAR(30), 
	CONSTRAINT accounts_pkey PRIMARY KEY (user_id)
);

CREATE TABLE case_records (
	user_id SERIAL NOT NULL, 
	criminal_records_url VARCHAR(255), 
	court_case_number VARCHAR(10), 
	legal_status VARCHAR(50), 
	arrest_date DATE, 
	charges TEXT, 
	case_outcome VARCHAR(100), 
	attorney_name VARCHAR(100), 
	court_location VARCHAR(100), 
	sentencing_date DATE, 
	fine_amount NUMERIC(15, 2), 
	CONSTRAINT case_records_pkey PRIMARY KEY (user_id)
);

CREATE TABLE citizens (
	user_id SERIAL NOT NULL, 
	gender VARCHAR(10), 
	race_ethnicity VARCHAR(50), 
	citizenship_status VARCHAR(50), 
	aadhar_number VARCHAR(16), 
	passport_number VARCHAR(10), 
	voter_id_number VARCHAR(20), 
	driving_license_number VARCHAR(20), 
	rc_number VARCHAR(20), 
	ration_card_number VARCHAR(20), 
	udid VARCHAR(20), 
	arogyasri_health_card_id VARCHAR(20), 
	marital_status VARCHAR(20), 
	birth_date DATE, 
	birth_place VARCHAR(100), 
	religion VARCHAR(50), 
	language_spoken VARCHAR(50), 
	CONSTRAINT citizens_pkey PRIMARY KEY (user_id)
);

CREATE TABLE ehr_data (
	user_id SERIAL NOT NULL, 
	medical_records_url VARCHAR(255), 
	patient_id VARCHAR(10), 
	health_insurance_info_url VARCHAR(255), 
	blood_type VARCHAR(5), 
	allergies TEXT, 
	last_checkup_date DATE, 
	current_medications TEXT, 
	primary_care_physician VARCHAR(100), 
	emergency_contact_name VARCHAR(50), 
	emergency_contact_phone VARCHAR(15), 
	vaccination_status VARCHAR(20), 
	bmi NUMERIC(5, 2), 
	chronic_conditions TEXT, 
	next_appointment_date DATE, 
	personal_notes TEXT, 
	CONSTRAINT ehr_data_pkey PRIMARY KEY (user_id)
);

CREATE TABLE employees (
	user_id SERIAL NOT NULL, 
	employee_id VARCHAR(10), 
	work_history_url VARCHAR(255), 
	salary_compensation_url VARCHAR(255), 
	username VARCHAR(50), 
	email_address VARCHAR(100), 
	ip_address VARCHAR(15), 
	device_identifier VARCHAR(17), 
	job_title VARCHAR(50), 
	department VARCHAR(50), 
	hire_date DATE, 
	termination_date DATE, 
	manager_name VARCHAR(100), 
	employment_status VARCHAR(20), 
	office_location VARCHAR(100), 
	CONSTRAINT employees_pkey PRIMARY KEY (user_id)
);


CREATE TABLE students (
	user_id SERIAL NOT NULL, 
	student_id_number VARCHAR(10), 
	educational_records_url VARCHAR(255), 
	school_name VARCHAR(100), 
	graduation_year INTEGER, 
	degree_obtained VARCHAR(50), 
	major_subject VARCHAR(50), 
	academic_honors VARCHAR(100), 
	extracurricular_activities TEXT, 
	CONSTRAINT students_pkey PRIMARY KEY (user_id)
);

CREATE TABLE users_data (
	user_id SERIAL NOT NULL, 
	full_name VARCHAR(100), 
	first_name VARCHAR(50), 
	last_name VARCHAR(50), 
	residential_address VARCHAR(255), 
	house_number VARCHAR(20), 
	phone_number VARCHAR(15), 
	income_tax VARCHAR(100), 
	house_tax VARCHAR(100), 
	city VARCHAR(50), 
	state VARCHAR(50), 
	zip_code VARCHAR(10), 
	bedrooms INTEGER, 
	bathrooms INTEGER, 
	square_feet INTEGER, 
	year_built INTEGER, 
	price NUMERIC(15, 2), 
	garage BOOLEAN, 
	swimming_pool BOOLEAN, 
	heating_type VARCHAR(50), 
	cooling_type VARCHAR(50), 
	lot_size NUMERIC(10, 2), 
	hoa_fee NUMERIC(10, 2), 
	property_type VARCHAR(50), 
	listing_date DATE, 
	realtor_id INTEGER, 
	CONSTRAINT users_pkey PRIMARY KEY (user_id)
);

INSERT INTO accounts VALUES
  (1, '1234567890123456', '9876543210123456', 'CUS123', 'ABCD1234EF', 'https://credit_history.com/user1', 50000.00, 0.00, NULL, '2024-03-13', 'https://investment_portfolio.com/user1', 'Blue', 7, 'Fluffy', 'The Matrix', 8.5, 5, 9, 'Random text here.', 'Secret123');

INSERT INTO accounts VALUES
  (2, '9876543210123456', '1234567890123456', 'CUS456', 'WXYZ5678GH', 'https://credit_history.com/user2', 75000.50, 15000.00, '2024-03-10', NULL, 'https://investment_portfolio.com/user2', 'Green', 3, 'Buddy', 'Inception', 9.0, 10, 8, 'Some more random text.', 'Code987');

INSERT INTO case_records VALUES
  (1, 'https://criminal_records.com/user1', 'CASE123', 'Pending', '2024-03-10', 'Theft, Fraud', 'Pending', 'John Doe', 'City Court', NULL, 0.00);

INSERT INTO case_records VALUES
  (2, 'https://criminal_records.com/user2', 'CASE456', 'Closed', '2023-12-05', 'Assault', 'Guilty', 'Jane Doe', 'District Court', '2024-01-15', 5000.00);

INSERT INTO ehr_data VALUES
  (1, 'https://medical_records.com/user1', 'PATIENT123', 'https://health_insurance_info.com/user1', 'O+', 'Peanuts, Penicillin', '2023-12-01', 'Aspirin', 'Dr. Smith', 'Emergency Contact', '123-456-7890', 'Up to date', 25.5, 'Hypertension, Diabetes', '2024-06-01', 'No specific notes.');

INSERT INTO ehr_data VALUES
  (2, 'https://medical_records.com/user2', 'PATIENT456', 'https://health_insurance_info.com/user2', 'A-', 'None', '2024-01-20', 'Antibiotics', 'Dr. Johnson', 'Emergency Contact 2', '987-654-3210', 'Incomplete', 22.0, 'None', '2024-07-15', 'Patient prefers email communication.');

INSERT INTO employees VALUES
  (1, 'EMP123', 'https://work_history.com/user1', 'https://salary_compensation.com/user1', 'john_doe', 'john.doe@email.com', '192.168.1.1', 'ABC123DEF456GHI78', 'Software Engineer', 'IT', '2020-02-15', NULL, 'Mary Johnson', 'Active', 'Reykjavik');

INSERT INTO employees VALUES
  (2, 'EMP456', 'https://work_history.com/user2', 'https://salary_compensation.com/user2', 'jane_smith', 'jane.smith@email.com', '192.168.1.2', 'JKL910MNO111PQR12', 'Marketing Specialist', 'Marketing', '2019-08-10', '2022-03-05', 'David Williams', 'Terminated', 'Akureyri');

INSERT INTO students VALUES
  (1, 'STU123', 'https://educational_records.com/user1', 'University of Reykjavik', 2022, 'Bachelor of Science', 'Computer Science', 'Cum Laude', 'Programming Club, Robotics Team');

INSERT INTO students VALUES
  (2, 'STU456', 'https://educational_records.com/user2', 'Akureyri College', 2021, 'Bachelor of Arts', 'Marketing', 'Magna Cum Laude', 'Marketing Club, Debate Team');

INSERT INTO users_data VALUES
  (1, 'John Doe', 'John', 'Doe', '123 Main St, Reykjavik', 'Apt 5B', '123-456-7890', 'ABCD1234TAX', 'WXYZ5678TAX', 'Reykjavik', 'Capital', '101', 3, 2, 1500, 1980, 300000.00, TRUE, TRUE, 'Central Heating', 'Air Conditioning', 0.25, 50.00, 'House', '2024-03-13', 789);

INSERT INTO users_data VALUES
  (2, 'Jane Smith', 'Jane', 'Smith', '456 Oak St, Akureyri', 'Unit 10', '987-654-3210', 'EFGH5678TAX', 'IJKL9101TAX', 'Akureyri', 'Northeast', '201', 4, 3, 2000, 1995, 400000.50, TRUE, FALSE, 'Radiant Floor Heating', 'None', 0.35, 75.00, 'Condo', '2024-03-10', 456);


