-- Classes table
CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Subclasses table
CREATE TABLE subclasses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_class_id INTEGER REFERENCES classes(id)
);

-- Taxonomic Orders table
CREATE TABLE taxonomic_orders (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_subclass_id INTEGER REFERENCES subclasses(id)
);

-- Families table
CREATE TABLE families (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_order_id INTEGER REFERENCES taxonomic_orders(id)
);

-- Genera table
CREATE TABLE genera (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_family_id INTEGER REFERENCES families(id)
);

-- Species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    scientific_name VARCHAR(255) NOT NULL,
    common_name VARCHAR(255),
    iucn_status VARCHAR(255),
    conservation_status VARCHAR(255),
    estimated_population VARCHAR(255),
    height VARCHAR(255),
    weight VARCHAR(255),
    lifespan VARCHAR(255),
    lifespan_in_wild VARCHAR(255),
    lifespan_in_zoo VARCHAR(255),
    habitat VARCHAR(255),
    diet VARCHAR(255),
    predators VARCHAR(255),
    breeding_season VARCHAR(255),
    breeding_location VARCHAR(255),
    egg_color VARCHAR(255),
    egg_shape VARCHAR(255),
    egg_size VARCHAR(255),
    eggs_per_chick INTEGER,
    clutch_duration VARCHAR(50),
    chick_ready_to_sea VARCHAR(50),
    parent_genus_id INTEGER REFERENCES genera(id)
);

-- Insert Basic Data

-- Classes
INSERT INTO classes (name) VALUES ('Mammalia');
INSERT INTO classes (name) VALUES ('Aves');
INSERT INTO classes (name) VALUES ('Reptilia');
INSERT INTO classes (name) VALUES ('Amphibia');
INSERT INTO classes (name) VALUES ('Insecta');
INSERT INTO classes (name) VALUES ('Fungi');
INSERT INTO classes (name) VALUES ('Plantae');
INSERT INTO classes (name) VALUES ('Protozoa');

-- Subclasses

-- Taxonomic Orders

-- Families

-- Genera

-- Species