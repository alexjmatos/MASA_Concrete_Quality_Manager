DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS site_residents;
DROP TABLE IF EXISTS building_sites;
DROP TABLE IF EXISTS concrete_volumetric_weight;
DROP TABLE IF EXISTS concrete_testing_orders;
DROP TABLE IF EXISTS concrete_testing_samples;
DROP TABLE IF EXISTS concrete_testing_cylinder_samples;

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

CREATE TABLE IF NOT EXISTS concrete_testing_samples
(
    id                        INTEGER PRIMARY KEY AUTOINCREMENT,
    plant_time                VARCHAR(255),
    building_site_time        VARCHAR(255),
    real_slumping_cm          REAL,
    temperature_celsius       REAL,
    location                  VARCHAR(255),
    concrete_testing_order_id INTEGER REFERENCES concrete_testing_orders (id)
);

CREATE TABLE IF NOT EXISTS concrete_testing_cylinder_samples
(
    id                            INTEGER PRIMARY KEY AUTOINCREMENT,
    testing_age_days              INTEGER,
    testing_date                  INTEGER,
    total_load_kg                 REAL,
    resistance_kgf_cm2            REAL,
    median                        REAL,
    percentage                    REAL,
    concrete_testing_sample_id INTEGER REFERENCES concrete_testing_samples (id)
);

INSERT INTO customers (identifier, company_name)
VALUES ('EPICO CONCRETOS', 'RFC001'),
       ('ARQCOZ CONSTRUCTORA', 'RFC002');

INSERT INTO site_residents (first_name, last_name, job_position)
VALUES ('MIRIAM', 'MATOS', 'MANAGER'),
       ('EMILIANO', 'MERINO', 'ENGINEER');

INSERT INTO building_sites (site_name, customer_id, site_resident_id)
VALUES ('SITE A', 1, 1),
       ('SITE B', 2, 2);

INSERT INTO concrete_testing_orders(id, design_resistance, slumping_cm, volume_m3, tma_mm, design_age, testing_date,
                                    customer_id, building_site_id, site_resident_id, concrete_volumetric_weight_id)
VALUES (1, '250', 14, 7, 20, '28', 1716319147750, 1, 1, 1, null);