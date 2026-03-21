
CREATE TABLE place (
    id SERIAL PRIMARY KEY,
    position_x NUMERIC,
    position_y NUMERIC,
    position_z NUMERIC
);

CREATE TABLE shape (
    id SERIAL PRIMARY KEY,
    color VARCHAR,
    round BOOLEAN,
    description VARCHAR
);

CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    age INTEGER,
    gender VARCHAR,
    rank VARCHAR,
    is_operator BOOLEAN,
    using_panel BOOLEAN
);

CREATE TABLE control_panel (
    id SERIAL PRIMARY KEY,
    name VARCHAR
);

CREATE TYPE spaceship_type AS ENUM ('liner', 'cargo', 'commerical', 'dreadnought', 'battleship');

CREATE TABLE spaceship (
    id SERIAL PRIMARY KEY,
    object_code VARCHAR UNIQUE,
    type spaceship_type,
    place_id INTEGER REFERENCES place(id),
    shape_id INTEGER REFERENCES shape(id)
);

CREATE TABLE trajectory (
    id SERIAL PRIMARY KEY,
    spaceship_id INTEGER REFERENCES spaceship(id),
    position_x NUMERIC,
    position_y NUMERIC,
    position_z NUMERIC
);

CREATE TABLE asteroid (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    place_id INTEGER REFERENCES place(id),
    size NUMERIC,
    shape_id INTEGER REFERENCES shape(id)
);

CREATE TABLE star_point (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    place_id INTEGER REFERENCES place(id),
    magnitude NUMERIC,
    shape_id INTEGER REFERENCES shape(id)
);

CREATE TABLE observation (
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    operator_id INTEGER REFERENCES characters(id),
    panel_id INTEGER REFERENCES control_panel(id),
    shape_id INTEGER REFERENCES shape(id),
    spaceship_id INTEGER REFERENCES spaceship(id),
    brightness NUMERIC,
    visibility VARCHAR
);


INSERT INTO place (position_x, position_y, position_z) VALUES (100.5, 200.7, 300.9);
INSERT INTO place (position_x, position_y, position_z) VALUES (500.0, 600.2, 700.1);
INSERT INTO place (position_x, position_y, position_z) VALUES (150.0, 250.0, 350.0);
INSERT INTO place (position_x, position_y, position_z) VALUES (400.5, 500.5, 600.5);
INSERT INTO place (position_x, position_y, position_z) VALUES (800.0, 900.0, 1000.0);

INSERT INTO shape (color, round, description) VALUES ('red', true, 'Spherical red object');
INSERT INTO shape (color, round, description) VALUES ('blue', false, 'Jagged blue structure');
INSERT INTO shape (color, round, description) VALUES ('green', true, 'Glowing green sphere');
INSERT INTO shape (color, round, description) VALUES ('yellow', false, 'Irregular yellow mass');
INSERT INTO shape (color, round, description) VALUES ('purple', true, 'Deep purple orb');

INSERT INTO characters (name, age, gender, rank, is_operator, using_panel) VALUES ('Pul', 35, 'male', 'captain', true, true);
INSERT INTO characters (name, age, gender, rank, is_operator, using_panel) VALUES ('Lina', 28, 'female', 'lieutenant', true, false);
INSERT INTO characters (name, age, gender, rank, is_operator, using_panel) VALUES ('Mark', 40, 'male', 'engineer', false, false);
INSERT INTO characters (name, age, gender, rank, is_operator, using_panel) VALUES ('Sara', 32, 'female', 'navigator', true, true);
INSERT INTO characters (name, age, gender, rank, is_operator, using_panel) VALUES ('Jon', 45, 'male', 'commander', true, false);

INSERT INTO control_panel (name) VALUES ('main control panel');
INSERT INTO control_panel (name) VALUES ('secondary panel');
INSERT INTO control_panel (name) VALUES ('engine control panel');
INSERT INTO control_panel (name) VALUES ('navigation panel');
INSERT INTO control_panel (name) VALUES ('observation panel');

INSERT INTO spaceship (object_code, type, place_id, shape_id) VALUES ('7794', 'commerical', 1, 1);
INSERT INTO spaceship (object_code, type, place_id, shape_id) VALUES ('8801', 'cargo', 2, 2);
INSERT INTO spaceship (object_code, type, place_id, shape_id) VALUES ('9902', 'liner', 3, 3);
INSERT INTO spaceship (object_code, type, place_id, shape_id) VALUES ('1234', 'dreadnought', 4, 4);
INSERT INTO spaceship (object_code, type, place_id, shape_id) VALUES ('5678', 'battleship', 5, 5);

INSERT INTO trajectory (spaceship_id, position_x, position_y, position_z) VALUES (1, 101.0, 202.0, 303.0);
INSERT INTO trajectory (spaceship_id, position_x, position_y, position_z) VALUES (2, 505.0, 606.0, 707.0);
INSERT INTO trajectory (spaceship_id, position_x, position_y, position_z) VALUES (3, 151.0, 252.0, 353.0);
INSERT INTO trajectory (spaceship_id, position_x, position_y, position_z) VALUES (4, 404.0, 505.0, 606.0);
INSERT INTO trajectory (spaceship_id, position_x, position_y, position_z) VALUES (5, 808.0, 909.0, 1009.0);

INSERT INTO asteroid (name, place_id, size, shape_id) VALUES ('Asteroid-X', 1, 1200.5, 1);
INSERT INTO asteroid (name, place_id, size, shape_id) VALUES ('Asteroid-Y', 2, 1500.0, 2);
INSERT INTO asteroid (name, place_id, size, shape_id) VALUES ('Asteroid-Z', 3, 900.3, 3);
INSERT INTO asteroid (name, place_id, size, shape_id) VALUES ('Asteroid-A', 4, 2000.0, 4);
INSERT INTO asteroid (name, place_id, size, shape_id) VALUES ('Asteroid-B', 5, 1800.7, 5);

INSERT INTO star_point (name, place_id, magnitude, shape_id) VALUES ('Star-A', 1, 3.5, 1);
INSERT INTO star_point (name, place_id, magnitude, shape_id) VALUES ('Star-B', 2, 4.1, 2);
INSERT INTO star_point (name, place_id, magnitude, shape_id) VALUES ('Star-C', 3, 2.8, 3);
INSERT INTO star_point (name, place_id, magnitude, shape_id) VALUES ('Star-D', 4, 5.0, 4);
INSERT INTO star_point (name, place_id, magnitude, shape_id) VALUES ('Star-E', 5, 3.9, 5);

INSERT INTO observation (start_time, end_time, operator_id, panel_id, shape_id, spaceship_id, brightness, visibility) VALUES ('2024-06-01 10:00:00', '2024-06-01 12:00:00', 1, 1, 1, 1, 500, 'high');
INSERT INTO observation (start_time, end_time, operator_id, panel_id, shape_id, spaceship_id, brightness, visibility) VALUES ('2024-06-02 09:00:00', '2024-06-02 11:00:00', 2, 2, 2, 2, 300, 'medium');
INSERT INTO observation (start_time, end_time, operator_id, panel_id, shape_id, spaceship_id, brightness, visibility) VALUES ('2024-06-03 14:00:00', '2024-06-03 16:00:00', 4, 4, 3, 3, 700, 'high');