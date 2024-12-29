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
    parent_genus_id INT, 
    FOREIGN KEY (parent_genus_id) REFERENCES genera(id)
);

-- Create species_translations table
CREATE TABLE species_translations (
    id SERIAL PRIMARY KEY,
    species_id INT NOT NULL, 
    language_code VARCHAR(10) NOT NULL, 
    common_name VARCHAR(255) NOT NULL, 
    iucn_status VARCHAR(10), 
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
    eggs_per_chick INT, 
    clutch_duration VARCHAR(255), 
    chick_ready_to_sea VARCHAR(255), 
    FOREIGN KEY (species_id) REFERENCES species(id) 
);

-- Insert Basic Data

-- Insert into classes
INSERT INTO classes DEFAULT VALUES; -- class_id = 1
INSERT INTO class_translations (class_id, language_code, name) VALUES
(1, 'en', 'Aves'),
(1, 'th', 'นก');

-- Insert into subclasses
INSERT INTO subclasses (parent_class_id) VALUES (1); -- subclass_id = 1, Palaeognathae
INSERT INTO subclass_translations (subclass_id, language_code, name) VALUES
(1, 'en', 'Palaeognathae'),
(1, 'th', 'นกโบราณ');

INSERT INTO subclasses (parent_class_id) VALUES (1); -- subclass_id = 2, Neognathae
INSERT INTO subclass_translations (subclass_id, language_code, name) VALUES
(2, 'en', 'Neognathae'),
(2, 'th', 'นกขากรรไกรใหม่');

-- Insert into taxonomic_orders
INSERT INTO taxonomic_orders (parent_subclass_id) VALUES (1); -- taxonomic_order_id = 1, Struthioniformes
INSERT INTO taxonomic_order_translations (taxonomic_order_id, language_code, name) VALUES
(1, 'en', 'Struthioniformes'),
(1, 'th', 'สตรูทิโอนิฟอร์ม');

INSERT INTO taxonomic_orders (parent_subclass_id) VALUES (2); -- taxonomic_order_id = 2, Sphenisciformes
INSERT INTO taxonomic_order_translations (taxonomic_order_id, language_code, name) VALUES
(2, 'en', 'Sphenisciformes'),
(2, 'th', 'สเฟนิสซิฟอร์ม');

-- Insert into families
INSERT INTO families (parent_order_id) VALUES (1); -- family_id = 1, Apterygidae
INSERT INTO family_translations (family_id, language_code, name) VALUES
(1, 'en', 'Apterygidae'),
(1, 'th', 'แอพเทอริจิเด');

INSERT INTO families (parent_order_id) VALUES (2); -- family_id = 2, Spheniscidae
INSERT INTO family_translations (family_id, language_code, name) VALUES
(2, 'en', 'Spheniscidae'),
(2, 'th', 'สเฟนิสซิเด');

-- Insert into genera
INSERT INTO genera (parent_family_id) VALUES (1); -- genus_id = 1, Apteryx
INSERT INTO genus_translations (genus_id, language_code, name) VALUES
(1, 'en', 'Apteryx'),
(1, 'th', 'แอพเทอริกซ์');

INSERT INTO genera (parent_family_id) VALUES (2); -- genus_id = 2, Aptenodytes
INSERT INTO genus_translations (genus_id, language_code, name) VALUES
(2, 'en', 'Aptenodytes'),
(2, 'th', 'แอพทีโนไดทีส');

-- Insert into species
INSERT INTO species (scientific_name, parent_genus_id)
VALUES
('Apteryx mantelli', 1), -- Brown Kiwi
('Aptenodytes forsteri', 2); -- Emperor Penguin

--- Insert into species_translations (Thai translations)
INSERT INTO species_translations (species_id, language_code, common_name, iucn_status, conservation_status, estimated_population, height, weight, lifespan, lifespan_in_wild, lifespan_in_zoo, habitat, diet, predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, eggs_per_chick, clutch_duration, chick_ready_to_sea) 
VALUES 
(1, 'th', 'กีวีสีน้ำตาลเหนือ', 'VU', 'ใกล้สูญพันธุ์', 'มีน้อยกว่า 5,000 ตัว', '45-55 ซม.', '1.3-3.5 กก.', '30-40 ปี', '25 ปี', '50 ปี', 'ป่าของนิวซีแลนด์', 'กินทั้งสัตว์และพืช', 'สโต๊ต, สุนัข', 'ฤดูหนาว', 'นิวซีแลนด์', 'สีน้ำตาล', 'รูปไข่', '5-6 ซม.', 1, '50 วัน', '6 เดือน'),
(2, 'th', 'เพนกวินจักรพรรดิ', 'NT', 'เปราะบาง', 'น้อยกว่า 100,000 ตัว', '100-130 ซม.', '22-45 กก.', '20 ปี', '15 ปี', '30 ปี', 'เขตแอนตาร์กติกและย่อยแอนตาร์กติก', 'กินเนื้อ', 'แมวน้ำ, ฉลาม', 'ฤดูหนาว', 'แอนตาร์กติก', 'สีขาว', 'รูปไข่', '8-10 ซม.', 1, '40 วัน', '5 เดือน');
-- Insert into species_translations (English translations)
INSERT INTO species_translations (species_id, language_code, common_name, iucn_status, conservation_status, estimated_population, height, weight, lifespan, lifespan_in_wild, lifespan_in_zoo, habitat, diet, predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, eggs_per_chick, clutch_duration, chick_ready_to_sea) 
VALUES 
(1, 'en', 'Brown Kiwi', 'VU', 'Vulnerable', 'Less than 5,000 individuals', '45-55 cm', '1.3-3.5 kg', '30-40 years', '25 years', '50 years', 'New Zealand forests', 'Omnivorous', 'Stoats, Dogs', 'Winter season', 'New Zealand', 'Brown', 'Oval', '5-6 cm', 1, '50 days', '6 months'),
(2, 'en', 'Emperor Penguin', 'NT', 'Near Threatened', 'Less than 100,000 individuals', '100-130 cm', '22-45 kg', '20 years', '15 years', '30 years', 'Antarctic and Subantarctic regions', 'Carnivorous', 'Seals, Sharks', 'Winter season', 'Antarctica', 'White', 'Oval', '8-10 cm', 1, '40 days', '5 months');
