CREATE TABLE Sales (
  year INTEGER NOT NULL,
  sale INTEGER NOT NULL
);

INSERT INTO Sales VALUES
  (1990, 50),
  (1991, 51),
  (1992, 52),
  (1993, 52),
  (1994, 50),
  (1995, 50),
  (1996, 49),
  (1997, 55);


CREATE TABLE Sales2 (
  year INTEGER NOT NULL,
  sale INTEGER NOT NULL
);

INSERT INTO Sales2 VALUES
  (1990, 50),
  (1992, 50),
  (1993, 52),
  (1994, 55),
  (1997, 55);


CREATE TABLE Shohin (
  id    CHAR(8)   NOT NULL,
  name  CHAR(16)  NOT NULL,
  genre CHAR(16)  NOT NULL,
  price INTEGER   NOT NULL
);

INSERT INTO Shohin VALUES
  ('0001', 'Tシャツ', '衣服', 1000),
  ('0002', '穴あけパンチ', '事務用品', 500),
  ('0003', 'カッターシャツ', '衣服', 4000),
  ('0004', '包丁', 'キッチン用品', 3000),
  ('0005', '圧力鍋', 'キッチン用品', 6800),
  ('0006', 'フォーク', 'キッチン用品', 500),
  ('0007', 'おろしがね', 'キッチン用品', 880),
  ('0008', 'ボールペン', '事務用品', 100);


CREATE TABLE Reservations (
  reserver    CHAR(8) NOT NULL,
  start_date  DATE    NOT NULL,
  end_date    DATE    NOT NULL
);

INSERT INTO Reservations VALUES
  ('木村', '2018-10-26', '2018-10-27'),
  ('荒木', '2018-10-28', '2018-10-31'),
  ('堀', '2018-10-31', '2018-11-01'),
  ('山本', '2018-11-03', '2018-11-04'),
  ('内田', '2018-11-03', '2018-11-05'),
  ('水谷', '2018-11-04', '2018-11-06');

