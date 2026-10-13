CREATE DATABASE IF NOT EXISTS `Insurance company` CHARACTER SET utf8mb4;
USE `Insurance company`;

CREATE TABLE Users (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'agent', 'client') NOT NULL
);

CREATE TABLE Clients (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_user INT UNSIGNED UNIQUE NOT NULL,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50),
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Branches (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(500) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Insurance_Agents (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_user INT UNSIGNED UNIQUE NOT NULL,
    id_branch INT UNSIGNED NOT NULL,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50),
    address VARCHAR(500) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (id_branch) REFERENCES Branches(id) ON DELETE CASCADE
);

CREATE TABLE Insurance_Types (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    agent_percentage DECIMAL(5, 2) NOT NULL
);

CREATE TABLE Contracts (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_branch INT UNSIGNED NOT NULL,
    id_client INT UNSIGNED NOT NULL,
    id_agent INT UNSIGNED NOT NULL,
    id_insurance_type INT UNSIGNED NOT NULL,
    date_signed DATE NOT NULL,
    insurance_amount DECIMAL(15, 2) NOT NULL,
    tariff_rate DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (id_branch) REFERENCES Branches(id) ON DELETE RESTRICT,
    FOREIGN KEY (id_client) REFERENCES Clients(id) ON DELETE RESTRICT,
    FOREIGN KEY (id_agent) REFERENCES Insurance_Agents(id) ON DELETE RESTRICT,
    FOREIGN KEY (id_insurance_type) REFERENCES Insurance_Types(id) ON DELETE RESTRICT
);

INSERT INTO Branches (name, address, phone_number) VALUES
  ('Филиал Центральный', 'г. Москва, ул. Тверская, д. 1', '+7 495 123-45-01'),
  ('Филиал Северный',   'г. Санкт-Петербург, Невский пр., д. 10', '+7 812 234-56-02'),
  ('Филиал Южный',      'г. Краснодар, ул. Красная, д. 5', '+7 861 345-67-03');

INSERT INTO Users (login, password, role) VALUES
  ('admin',   'a',  'admin'),
  ('agent1',  '1',  'agent'),
  ('agent2',  '2',  'agent'),
  ('agent3',  '3',  'agent'),
  ('agent4',  '4',  'agent'),
  ('agent5',  '5',  'agent'),
  ('client1', 'c',  'client'),
  ('client2', 'c',  'client'),
  ('client3', 'c',  'client'),
  ('client4', 'c',  'client'),
  ('client5', 'c',  'client'),
  ('client6', 'c',  'client'),
  ('client7', 'c',  'client'),
  ('client8', 'c',  'client'),
  ('client9', 'c',  'client'),
  ('client10','c',  'client');

INSERT INTO Insurance_Types (name, agent_percentage) VALUES
  ('Жизнь', 10.00),
  ('Авто', 12.50),
  ('Медицинское', 8.00),
  ('Имущество', 11.00),
  ('Путешествия', 9.50),
  ('Ответственность', 7.00),
  ('Домашние животные', 6.00),
  ('Инвалидность', 8.50),
  ('Несчастный случай', 9.00),
  ('Кибербезопасность', 13.00);

INSERT INTO Clients (id_user, surname, name, patronymic, date_of_birth, phone_number) VALUES
  (7,  'Иванов',    'Иван',      'Иванович',     '1980-05-10', '+7 926 000-11-11'),
  (8,  'Петров',    'Пётр',      'Петрович',     '1975-08-20', '+7 926 000-22-22'),
  (9,  'Сидоров',   'Сидор',     'Сидорович',    '1990-12-01', '+7 926 000-33-33'),
  (10, 'Кузнецов',  'Николай',   'Николаевич',   '1985-03-15', '+7 926 000-44-44'),
  (11, 'Смирнова',  'Анна',      'Алексеевна',   '1992-07-22', '+7 926 000-55-55'),
  (12, 'Волкова',   'Елена',     'Игоревна',     '1988-11-30', '+7 926 000-66-66'),
  (13, 'Морозов',   'Дмитрий',   'Дмитриевич',   '1979-02-28', '+7 926 000-77-77'),
  (14, 'Новикова',  'Ольга',     'Сергеевна',    '1995-09-05', '+7 926 000-88-88'),
  (15, 'Фёдоров',   'Алексей',   'Алексеевич',   '1983-04-12', '+7 926 000-99-99'),
  (16, 'Михайлова', 'Мария',     'Владимировна', '1991-01-18', '+7 926 001-00-00');

INSERT INTO Insurance_Agents (id_user, id_branch, surname, name, patronymic, address, phone_number) VALUES
  (2, 1, 'Серов',     'Павел',      'Игоревич',    'г. Москва, ул. Ленина, д. 2', '+7 916 100-11-11'),
  (3, 1, 'Орлова',    'Екатерина',  'Владимировна','г. Москва, ул. Пушкина, д. 5','+7 916 100-22-22'),
  (4, 2, 'Виноградов','Роман',      'Александрович','г. СПб, ул. Невская, д. 20',  '+7 812 200-33-33'),
  (5, 2, 'Крылова',   'Татьяна',    'Павловна',    'г. СПб, пр. Мира, д. 7',      '+7 812 200-44-44'),
  (6, 3, 'Лебедев',   'Андрей',     'Сергеевич',   'г. Краснодар, ул. Октябрьская, д. 3', '+7 861 300-55-55');

INSERT INTO Contracts (id_branch, id_client, id_agent, id_insurance_type, date_signed, insurance_amount, tariff_rate) VALUES
  (1,  1, 1,  1, '2023-01-15', 100000.00, 1.20),
  (1,  2, 2,  2, '2023-02-10',  75000.00, 1.15),
  (1,  3, 1,  3, '2023-03-05',  50000.00, 1.10),
  (1,  4, 2,  4, '2023-04-12', 120000.00, 1.25),
  (1,  5, 1,  5, '2023-05-20',  90000.00, 1.18),
  (2,  6, 3,  6, '2023-06-15',  60000.00, 1.22),
  (2,  7, 4,  7, '2023-07-01',  80000.00, 1.17),
  (2,  8, 3,  8, '2023-08-09', 110000.00, 1.30),
  (2,  9, 4,  9, '2023-09-17',  55000.00, 1.12),
  (2, 10, 3, 10, '2023-10-25', 130000.00, 1.28),
  (3,  1, 5,  1, '2024-01-05',  70000.00, 1.14),
  (3,  2, 5,  2, '2024-02-13',  95000.00, 1.19),
  (3,  3, 5,  3, '2024-03-21',  65000.00, 1.16),
  (3,  4, 5,  4, '2024-04-29', 125000.00, 1.24),
  (3,  5, 5,  5, '2024-05-07',  85000.00, 1.20),
  (1,  6, 1,  6, '2024-06-15',  78000.00, 1.21),
  (1,  7, 2,  7, '2024-07-23',  88000.00, 1.23),
  (2,  8, 3,  8, '2024-08-31',  92000.00, 1.27),
  (2,  9, 4,  9, '2024-09-08',  53000.00, 1.11),
  (3, 10, 5, 10, '2024-10-16', 150000.00, 1.32);


ALTER TABLE Users AUTO_INCREMENT = 1;
ALTER TABLE Clients AUTO_INCREMENT = 1;
ALTER TABLE Branches AUTO_INCREMENT = 1;
ALTER TABLE Insurance_Agents AUTO_INCREMENT = 1;
ALTER TABLE Insurance_Types AUTO_INCREMENT = 1;
ALTER TABLE Contracts AUTO_INCREMENT = 1;
