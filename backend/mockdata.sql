-- Classes table
CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Subclasses table
CREATE TABLE subclasses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_class_id INTEGER REFERENCES classes(id) ON DELETE CASCADE
);

-- Taxonomic Orders table
CREATE TABLE taxonomic_orders (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_subclass_id INTEGER REFERENCES subclasses(id) ON DELETE CASCADE
);

-- Families table
CREATE TABLE families (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_order_id INTEGER REFERENCES taxonomic_orders(id) ON DELETE CASCADE
);

-- Genera table
CREATE TABLE genera (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_family_id INTEGER REFERENCES families(id) ON DELETE CASCADE
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
    parent_genus_id INTEGER REFERENCES genera(id) ON DELETE CASCADE
);

-- Insert Mock Data

-- Classes
INSERT INTO classes (name) VALUES ('Mammalia');
INSERT INTO classes (name) VALUES ('Aves');
INSERT INTO classes (name) VALUES ('Reptilia');
INSERT INTO classes (name) VALUES ('Amphibia');
INSERT INTO classes (name) VALUES ('Insecta');
INSERT INTO classes (name) VALUES ('Fungi');
INSERT INTO classes (name) VALUES ('Plantae');
INSERT INTO classes (name) VALUES ('Protozoa');

-- Insert into subclasses
INSERT INTO subclasses (name, parent_class_id)
VALUES ('Palaeognathae', (SELECT id FROM classes WHERE name = 'Aves')), -- สำหรับกีวี
       ('Neognathae', (SELECT id FROM classes WHERE name = 'Aves')); -- สำหรับเพนกวิน

-- Insert into taxonomic_orders
INSERT INTO taxonomic_orders (name, parent_subclass_id)
VALUES ('Struthioniformes', (SELECT id FROM subclasses WHERE name = 'Palaeognathae')), -- สำหรับกีวี (ในทางปฏิบัติ กีวีอยู่ใน Apterygiformes แต่เพื่อความง่ายจะใช้ Struthioniformes ซึ่งใกล้เคียง)
       ('Sphenisciformes', (SELECT id FROM subclasses WHERE name = 'Neognathae')); -- สำหรับเพนกวิน

-- Insert into families
INSERT INTO families (name, parent_order_id)
VALUES ('Apterygidae', (SELECT id FROM taxonomic_orders WHERE name = 'Struthioniformes')), -- สำหรับกีวี (Apterygiformes)
       ('Spheniscidae', (SELECT id FROM taxonomic_orders WHERE name = 'Sphenisciformes')); -- สำหรับเพนกวิน

-- Insert into genera
INSERT INTO genera (name, parent_family_id)
VALUES ('Apteryx', (SELECT id FROM families WHERE name = 'Apterygidae')), -- สำหรับกีวี
       ('Aptenodytes', (SELECT id FROM families WHERE name = 'Spheniscidae')); -- สำหรับเพนกวิน (เช่น เพนกวินจักรพรรดิ)
INSERT INTO genera (name, parent_family_id)
VALUES ('Eudyptula', (SELECT id FROM families WHERE name = 'Spheniscidae')); -- สำหรับเพนกวิน (เช่น เพนกวินน้อย)

-- Insert into species (Kiwis)
INSERT INTO species (scientific_name, common_name, iucn_status, habitat, diet, predators, parent_genus_id)
VALUES ('Apteryx australis', 'กีวีน้ำตาลใต้', 'VU', 'ป่าดิบชื้น', 'แมลง, ไส้เดือน, ผลไม้', 'สุนัข, แมว, พังพอน', (SELECT id FROM genera WHERE name = 'Apteryx'));

INSERT INTO species (scientific_name, common_name, iucn_status, habitat, diet, predators, parent_genus_id)
VALUES ('Apteryx mantelli', 'กีวีเหนือ', 'EN', 'ป่าดิบชื้น', 'แมลง, ไส้เดือน, ผลไม้', 'สุนัข, แมว, พังพอน', (SELECT id FROM genera WHERE name = 'Apteryx'));

-- Insert into species (Penguins)
INSERT INTO species (scientific_name, common_name, iucn_status, height, weight, lifespan_in_wild, habitat, diet, predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, parent_genus_id)
VALUES ('Aptenodytes forsteri', 'เพนกวินจักรพรรดิ', 'NT', '120 ซม.', '30-40 กก.', '20 ปี', 'ทวีปแอนตาร์กติกา', 'ปลา, คริล, หมึก', 'แมวน้ำเสือดาว, วาฬออร์กา', 'มีนาคม-เมษายน', 'ทวีปแอนตาร์กติกา', 'ขาวอมเขียว', 'รูปไข่', '11-12 ซม.', (SELECT id FROM genera WHERE name = 'Aptenodytes'));

INSERT INTO species (scientific_name, common_name, iucn_status, lifespan_in_wild, habitat, diet, predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, parent_genus_id)
VALUES ('Eudyptula minor', 'เพนกวินน้อย', 'LC', '6-7 ปี', 'ชายฝั่งออสเตรเลียและนิวซีแลนด์', 'ปลาขนาดเล็ก, หมึก', 'นกทะเลขนาดใหญ่, สุนัขจิ้งจอก', 'ฤดูใบไม้ผลิ', 'ชายฝั่ง', 'ขาว', 'รูปไข่', 'ประมาณ 6 ซม.', (SELECT id FROM genera WHERE name = 'Eudyptula'));
