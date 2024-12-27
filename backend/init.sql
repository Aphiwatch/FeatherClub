-- Classes table
CREATE TABLE classes (
    id SERIAL PRIMARY KEY
);

CREATE TABLE class_translations (
    id SERIAL PRIMARY KEY,
    class_id INTEGER REFERENCES classes(id) ON DELETE CASCADE,
    language_code VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL,
    UNIQUE (class_id, language_code)
);

-- Subclasses table
CREATE TABLE subclasses (
    id SERIAL PRIMARY KEY,
    parent_class_id INTEGER REFERENCES classes(id) ON DELETE CASCADE
);

CREATE TABLE subclass_translations (
    id SERIAL PRIMARY KEY,
    subclass_id INTEGER REFERENCES subclasses(id) ON DELETE CASCADE,
    language_code VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL,
    UNIQUE (subclass_id, language_code)
);

-- Taxonomic Orders table
CREATE TABLE taxonomic_orders (
    id SERIAL PRIMARY KEY,
    parent_subclass_id INTEGER REFERENCES subclasses(id) ON DELETE CASCADE
);

CREATE TABLE taxonomic_order_translations (
    id SERIAL PRIMARY KEY,
    taxonomic_order_id INTEGER REFERENCES taxonomic_orders(id) ON DELETE CASCADE,
    language_code VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL,
    UNIQUE (taxonomic_order_id, language_code)
);

-- Families table
CREATE TABLE families (
    id SERIAL PRIMARY KEY,
    parent_order_id INTEGER REFERENCES taxonomic_orders(id) ON DELETE CASCADE
);

CREATE TABLE family_translations (
    id SERIAL PRIMARY KEY,
    family_id INTEGER REFERENCES families(id) ON DELETE CASCADE,
    language_code VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL,
    UNIQUE (family_id, language_code)
);

-- Genera table
CREATE TABLE genera (
    id SERIAL PRIMARY KEY,
    parent_family_id INTEGER REFERENCES families(id) ON DELETE CASCADE
);

CREATE TABLE genus_translations (
    id SERIAL PRIMARY KEY,
    genus_id INTEGER REFERENCES genera(id) ON DELETE CASCADE,
    language_code VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL,
    UNIQUE (genus_id, language_code)
);

-- Species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    scientific_name VARCHAR(255) NOT NULL,
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
    parent_genus_id INTEGER REFERENCES genera(id) ON DELETE CASCADE
);

CREATE TABLE species_translations (
    id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(id) ON DELETE CASCADE,
    language_code VARCHAR(10) NOT NULL,
    common_name VARCHAR(255),
    UNIQUE (species_id, language_code)
);

-- Insert Basic Data (ตัวอย่างการเพิ่มข้อมูล)

-- Classes and Translations
INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Mammalia');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'สัตว์เลี้ยงลูกด้วยนม');

INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Aves');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'นก');

INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Reptilia');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'สัตว์เลื้อยคลาน');

INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Amphibia');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'สัตว์ครึ่งบกครึ่งน้ำ');

INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Insecta');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'แมลง');

INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Fungi');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'เห็ดรา');

INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Plantae');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'พืช');

INSERT INTO classes DEFAULT VALUES;
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'en', 'Protozoa');
INSERT INTO class_translations (class_id, language_code, name) VALUES ((SELECT id FROM classes ORDER BY id DESC LIMIT 1), 'th', 'โพรโทซัว');