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
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    site_name   VARCHAR(255),
    customer_id INTEGER REFERENCES customers (id),
    site_resident_id INTEGER REFERENCES site_residents(id)
);

CREATE TABLE IF NOT EXISTS concrete_volumetric_weight
(
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    tare_weight_gr REAL,
    material_tare_weight_gr REAL,
    material_weight_gr REAL,
    tare_volume_cm3 REAL,
    volumetric_weight_gr_cm3 REAL,
    volume_load_m3 REAL,
    cement_quantity_kg REAL,
    coarse_aggregate_kg REAL,
    fine_aggregate_kg REAL,
    water_kg REAL,
    retardant_additive_lt REAL,
    other_additive_lt REAL,
    total_load_kg REAL,
    total_load_volumetric_weight_relation REAL,
    percentage REAL
);

CREATE TABLE IF NOT EXISTS concrete_testing_orders
(
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    design_resistance VARCHAR(255),
    slumping_cm       INTEGER,
    volume_m3         INTEGER,
    tma_mm            INTEGER,
    design_age        VARCHAR(255),
    testing_date      INTEGER,
    customer_id       INTEGER REFERENCES customers (id),
    building_site_id   INTEGER REFERENCES building_sites (id),
    site_resident_id  INTEGER REFERENCES site_residents (id),
    concrete_volumetric_weight_id INTEGER REFERENCES concrete_volumetric_weight(id)
);

INSERT INTO customers (id, identifier, company_name)
VALUES (NULL, 'SEDENA', '');

INSERT INTO site_residents (id, first_name, last_name, job_position)
VALUES (NULL, 'EDUARDO', 'PAZ', 'INGENIERO');

INSERT INTO site_residents (id, first_name, last_name, job_position)
VALUES (NULL, 'ALEJANDRO', 'MATOS', 'INGENIERO');

INSERT INTO building_sites (id, site_name, customer_id, site_resident_id)
VALUES (NULL, 'LA MOLINA', 1, 1);

INSERT INTO building_sites (id, site_name, customer_id, site_resident_id)
VALUES (NULL, 'BECAN', 1, 2);

INSERT INTO concrete_volumetric_weight(id,
                                       tare_weight_gr,
                                       material_tare_weight_gr,
                                       material_weight_gr,
                                       tare_volume_cm3,
                                       volumetric_weight_gr_cm3,
                                       volume_load_m3,
                                       cement_quantity_kg,
                                       coarse_aggregate_kg,
                                       fine_aggregate_kg,
                                       water_kg,
                                       retardant_additive_lt,
                                       other_additive_lt,
                                       total_load_kg,
                                       total_load_volumetric_weight_relation,
                                       percentage)
VALUES (1, 3480, 15180,11700,5.181,2258,7,2924,5518,5398,1500,4.36,14.53,15358,6.8,97.17);

INSERT INTO concrete_testing_orders(id, design_resistance, slumping_cm, volume_m3, tma_mm, design_age, testing_date, customer_id, building_site_id, site_resident_id, concrete_volumetric_weight_id)
VALUES (1, '250', 14, 7, 20, '28', 1716319147750, 1, 1, 1, 1);