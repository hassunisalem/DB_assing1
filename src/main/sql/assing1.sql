DROP TABLE IF EXISTS Cities CASCADE;
DROP TABLE IF EXISTS Caretakers CASCADE;
DROP TABLE IF EXISTS Vets CASCADE;
DROP TABLE IF EXISTS Pets CASCADE;
DROP TABLE IF EXISTS Pets_Caretakers CASCADE;
DROP TABLE IF EXISTS Addresses;


CREATE TABLE Cities (
    zipCode int PRIMARY KEY NOT NULL,
    cityName varchar(20) NOT NULL
);

CREATE TABLE Addresses (
    address_id SERIAL PRIMARY KEY,
    street varchar(100) NOT NULL,
    zipCode INT REFERENCES Cities NOT NULL
);

CREATE TABLE  Caretakers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL ,
    phone INT,
    address_id int REFERENCES Addresses
);

CREATE TABLE Vets (
    cvr INT PRIMARY KEY ,
    name VARCHAR(40),
    phone INT,
    address_id int REFERENCES Addresses
);

-- CREATE TYPE dtype AS ENUM (
   -- 'cat',
   -- 'dog',
  --  'other'
--    );

CREATE TABLE Pets (
   species dtype,
   pet_id SERIAL PRIMARY KEY,
   name VARCHAR(40),
   age INT,
   liveCount INT,
   barkPitch char(2)
);

CREATE TABLE Pets_Caretakers (
    caretaker_id int REFERENCES Caretakers (id) ON DELETE CASCADE,
    pet_id int REFERENCES Pets(pet_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pets_caretakers_pKey PRIMARY KEY (caretaker_id, pet_id)
);

-- VIEWS

CREATE OR REPLACE VIEW ALL_PETS AS
    SELECT * FROM Pets;

CREATE OR REPLACE VIEW ALL_CATS AS
    SELECT * FROM Pets WHERE species = 'cat';

CREATE OR REPLACE VIEW ALL_DOGS AS
    SELECT * FROM Pets WHERE species = 'dog';


-- PROCEDURES

CREATE OR REPLACE PROCEDURE insert_dog (
   _name VARCHAR(40), _age INT, _barkPitch CHAR(2)
)
LANGUAGE SQL
    AS $$
            WITH NEW_DOG AS (
              INSERT INTO Pets (species , name, age, liveCount, barkPitch) VALUES ('dog', _name, _age, null, _barkPitch)
            ) SELECT 'dog', _name, _age,null, _barkPitch;
    $$;


CREATE OR REPLACE PROCEDURE insert_cat (
    _name VARCHAR(40), _age INT, _liveCount INT
)
    LANGUAGE SQL
    AS $$
         WITH NEW_CAT AS (
            INSERT INTO Pets (species , name, age, liveCount, barkPitch) VALUES ('cat', _name, _age, _liveCount, null)
)           SELECT 'cat', _name, _age,_liveCount;
$$;


CREATE OR REPLACE PROCEDURE insert_animal (
    _name VARCHAR(40), _age INT
)
    LANGUAGE SQL
        AS $$
            WITH NEW_ANIMAL AS (
                INSERT INTO Pets (species , name, age) VALUES ('other', _name, _age)
)               SELECT 'other', _name, _age;
$$;


--- POPULATE WITH DATA

DELETE FROM cities;
DELETE FROM pets;
DELETE FROM caretakers;
DELETE FROM vets;
DELETE FROM all_pets;
DELETE FROM all_cats;
DELETE FROM all_dogs;



INSERT INTO cities (cityname, zipcode) VALUES ('Lyngby', 2800);
INSERT INTO cities (cityname, zipcode) VALUES ('Brøndby Strand', 2660);

INSERT INTO VETs (cvr, name) VALUES ('1', 'Paul');
INSERT INTO VETs (cvr, name) VALUES ('2', 'Tom');

INSERT INTO caretakers (name, phone) VALUES ('caretaker1',12345678);
INSERT INTO caretakers (name, phone) VALUES ('caretaker2',22345678);
INSERT INTO caretakers (name, phone) VALUES ('caretaker3',32345678);
INSERT INTO caretakers (name, phone) VALUES ('caretaker4',42345678);
INSERT INTO caretakers (name, phone) VALUES ('caretaker5',52345678);
INSERT INTO caretakers (name, phone) VALUES ('caretaker6',62345678);
INSERT INTO caretakers (name, phone) VALUES ('caretaker7',72345678);

CALL insert_dog('dog1',5,'b1');
CALL insert_dog('dog2',2,'b2');
CALL insert_dog('dog3',3,'X3');
CALL insert_dog('dog4',7,'Z3');
CALL insert_dog('dog5',1,'X1');
CALL insert_dog('dog6',1,'X2');
CALL insert_dog('dog7',1,'X3');
CALL insert_dog('dog8',1,'X1');

CALL insert_cat('cat1',3,0);
CALL insert_cat('cat2',2,4);
CALL insert_cat('cat3',5,4);
CALL insert_cat('cat4',3,2);
CALL insert_cat('lucky',1,9);
CALL insert_cat('cat6',1,4);
CALL insert_cat('cat7',1,1);
CALL insert_cat('cat8',1,2);

CALL insert_animal('monkey',5);
CALL insert_animal('donkey',2);
CALL insert_animal('horse',7);
CALL insert_animal('God Zilla',2000);


-- INSERT INTO pets_caretakers (caretaker_id, pet_id) VALUES (1, 1);
-- INSERT INTO pets_caretakers (caretaker_id, pet_id) VALUES (2, 2);
-- INSERT INTO pets_caretakers (caretaker_id, pet_id) VALUES (2, 1);
-- INSERT INTO pets_caretakers (caretaker_id, pet_id) VALUES (2, 3);
-- INSERT INTO pets_caretakers (caretaker_id, pet_id) VALUES (2, 4);
-- INSERT INTO pets_caretakers (caretaker_id, pet_id) VALUES (2, 6);
-- INSERT INTO pets_caretakers (caretaker_id, pet_id) VALUES (2, 5);
-- INSERT INTO pets_caretakers (caretaker_id, p