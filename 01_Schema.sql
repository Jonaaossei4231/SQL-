CREATE TABLE customer (
customer_id  INT GENERATED  ALWAYS AS IDENTITY PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name  VARCHAR(50) NOT NULL,
email      VARCHAR(120) NOT NULL UNIQUE,
Phone      VARCHAR(20),
password_hash TEXT      NOT NULL, --bcrypt via crypt ()
registered_at TIMESTAMP NOT NULL DEFAULT now() ,
is_active      BOOLEAN  NOT NULL DEFAULT TRUE
CHECK (email LIKE '%_@_%.__%')

);

CREATE TABLE station (
station_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
name VARCHAR (80) NOT NULL UNIQUE,
address VARCHAR(200) NOT NULL,
capacity INT         NOT NULL CHECK (Capacity>0)

);

CREATE TABLE bike_type (
bike_type_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(60)  NOT NULL UNIQUE,
address VARCHAR(300) NOT NULL,
capacity INT         NOT NULL CHECK(capacity > 0),
is_electric  BOOLEAN  NOT NULL DEFAULT FALSE,
hourly_rate  NUMERIC(6,2) NOT NULL CHECK(hourly_rate >=0)

);

CREATE TABLE staff (
staff_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 first_name   VARCHAR(60)     NOT NULL,
last_name  VARCHAR(60)  NOT NULL,
email         VARCHAR(150) NOT NULL UNIQUE,
role          VARCHAR (30) NOT NULL CHECK (role IN('station_staff','mechanic','manager')),
station_id INT REFERENCES station(station_id) ON DELETE SET NULL

);


CREATE TABLE rental (
    rental_id   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customer(customer_id) ON DELETE RESTRICT,
    bike_id     INT NOT NULL REFERENCES bike(bike_id)         ON DELETE RESTRICT,
    start_time  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time    TIMESTAMP,
    CHECK (end_time IS NULL OR end_time > start_time)

);
