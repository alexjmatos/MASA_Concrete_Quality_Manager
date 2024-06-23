DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS site_residents;
DROP TABLE IF EXISTS building_sites;
DROP TABLE IF EXISTS concrete_volumetric_weight;
DROP TABLE IF EXISTS concrete_testing_orders;

CREATE TABLE IF NOT EXISTS customers
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    identifier   VARCHAR(255),
    company_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS site_residents
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name   VARCHAR(255),
    last_name    VARCHAR(255),
    job_position VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS building_sites
(
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    site_name        VARCHAR(255),
    customer_id      INTEGER REFERENCES customers (id),
    site_resident_id INTEGER REFERENCES site_residents (id)
);

CREATE TABLE IF NOT EXISTS concrete_volumetric_weight
(
    id                                    INTEGER PRIMARY KEY AUTOINCREMENT,
    tare_weight_gr                        REAL,
    material_tare_weight_gr               REAL,
    material_weight_gr                    REAL,
    tare_volume_cm3                       REAL,
    volumetric_weight_gr_cm3              REAL,
    volume_load_m3                        REAL,
    cement_quantity_kg                    REAL,
    coarse_aggregate_kg                   REAL,
    fine_aggregate_kg                     REAL,
    water_kg                              REAL,
    additives                             TEXT,
    total_load_kg                         REAL,
    total_load_volumetric_weight_relation REAL,
    percentage                            REAL
);

CREATE TABLE IF NOT EXISTS concrete_testing_orders
(
    id                            INTEGER PRIMARY KEY AUTOINCREMENT,
    design_resistance             VARCHAR(255),
    slumping_cm                   INTEGER,
    volume_m3                     INTEGER,
    tma_mm                        INTEGER,
    design_age                    VARCHAR(255),
    testing_date                  INTEGER,
    customer_id                   INTEGER REFERENCES customers (id),
    building_site_id              INTEGER REFERENCES building_sites (id),
    site_resident_id              INTEGER REFERENCES site_residents (id),
    concrete_volumetric_weight_id INTEGER REFERENCES concrete_volumetric_weight (id)
);

CREATE TABLE IF NOT EXISTS concrete_testing_remissions
(
    id                        INTEGER PRIMARY KEY AUTOINCREMENT,
    plant_time                INTEGER,
    real_slumping_cm          REAL,
    temperature_celsius       REAL,
    location                  VARCHAR(255),
    concrete_testing_order_id INTEGER REFERENCES concrete_testing_orders (id)
);

CREATE TABLE IF NOT EXISTS concrete_testing_samples
(
    id                            INTEGER PRIMARY KEY AUTOINCREMENT,
    testing_age_days              INTEGER,
    testing_date                  INTEGER,
    total_load_kg                 REAL,
    resistance_kgf_cm2            REAL,
    median                        REAL,
    percentage                    REAL,
    concrete_testing_remission_id INTEGER REFERENCES concrete_testing_remissions (id)
);

INSERT INTO customers (identifier, company_name)
VALUES ('Alpha Construction', 'RFC001'),
       ('Beta Builders', 'RFC002'),
       ('Gamma Developments', 'RFC003'),
       ('Delta Contractors', 'RFC004'),
       ('Epsilon Engineering', 'RFC005');

INSERT INTO site_residents (first_name, last_name, job_position)
VALUES ('John', 'Doe', 'Site Manager'),
       ('Jane', 'Smith', 'Engineer'),
       ('Robert', 'Johnson', 'Foreman'),
       ('Emily', 'Davis', 'Safety Officer'),
       ('Michael', 'Brown', 'Project Manager');

INSERT INTO building_sites (site_name, customer_id, site_resident_id)
VALUES ('Site A', 1, 1),
       ('Site B', 2, 2),
       ('Site C', 3, 3),
       ('Site D', 4, 4),
       ('Site E', 5, 5);

INSERT INTO concrete_volumetric_weight (tare_weight_gr, material_tare_weight_gr, material_weight_gr, tare_volume_cm3,
                                        volumetric_weight_gr_cm3, volume_load_m3, cement_quantity_kg,
                                        coarse_aggregate_kg, fine_aggregate_kg, water_kg, additives, total_load_kg,
                                        total_load_volumetric_weight_relation, percentage)
VALUES (1000, 500, 1500, 2000, 2.5, 1.0, 300, 1200, 800, 150, '{"RETARDANTE": 4.46, "ADT383": 14.88}', 3000, 1.5, 25),
       (1100, 600, 1600, 2100, 2.6, 1.1, 310, 1250, 850, 160, '{"RETARDANTE": 4.46, "ADT383": 14.88}', 3100, 1.55, 26),
       (1200, 700, 1700, 2200, 2.7, 1.2, 320, 1300, 900, 170, '{"RETARDANTE": 4.46, "ADT383": 14.88}', 3200, 1.6, 27),
       (1300, 800, 1800, 2300, 2.8, 1.3, 330, 1350, 950, 180, '{"RETARDANTE": 4.46, "ADT383": 14.88}', 3300, 1.65, 28),
       (1400, 900, 1900, 2400, 2.9, 1.4, 340, 1400, 1000, 190, '{"RETARDANTE": 4.46, "ADT383": 14.88}', 3400, 1.7, 29);

INSERT INTO concrete_testing_orders (design_resistance, slumping_cm, volume_m3, tma_mm, design_age, testing_date,
                                     customer_id, building_site_id, site_resident_id, concrete_volumetric_weight_id)
VALUES ('250', 10, 20, 20, '28', strftime('%s', 'now'), 1, 1, 1, 1),
       ('300', 12, 25, 25, '28', strftime('%s', 'now'), 2, 2, 2, 2),
       ('350', 15, 30, 30, '28', strftime('%s', 'now'), 3, 3, 3, 3),
       ('400', 18, 35, 35, '28', strftime('%s', 'now'), 4, 4, 4, 4),
       ('450', 20, 40, 40, '28', strftime('%s', 'now'), 5, 5, 5, 5);
INSERT INTO concrete_testing_remissions (plant_time, real_slumping_cm, temperature_celsius, location,
                                         concrete_testing_order_id)
VALUES (strftime('%s', 'now'), 10.5, 25.0, 'Location A', 1),
       (strftime('%s', 'now'), 11.0, 26.0, 'Location B', 2),
       (strftime('%s', 'now'), 12.0, 27.0, 'Location C', 3),
       (strftime('%s', 'now'), 13.0, 28.0, 'Location D', 4),
       (strftime('%s', 'now'), 14.0, 29.0, 'Location E', 5);
INSERT INTO concrete_testing_samples (testing_age_days, testing_date, total_load_kg, resistance_kgf_cm2, median,
                                      percentage, concrete_testing_remission_id)
VALUES (7, strftime('%s', 'now'), 1000, 25.0, 26.0, 95.0, 1),
       (14, strftime('%s', 'now'), 1100, 26.0, 27.0, 96.0, 2),
       (28, strftime('%s', 'now'), 1200, 27.0, 28.0, 97.0, 3),
       (7, strftime('%s', 'now'), 1300, 28.0, 29.0, 98.0, 4),
       (14, strftime('%s', 'now'), 1400, 29.0, 30.0, 99.0, 5);