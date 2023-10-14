use ch08_outer_join;


CREATE TABLE Courses (
  name    VARCHAR(8) NOT NULL,
  course  VARCHAR(8) NOT NULL
);

INSERT INTO Courses VALUES
  ('赤井', 'SQL入門'),
  ('赤井', 'UNIX基礎'),
  ('鈴木', 'SQL入門'),
  ('工藤', 'SQL入門'),
  ('工藤', 'Java中級'),
  ('吉田', 'UNIX基礎'),
  ('渡辺', 'SQL入門');


CREATE TABLE Personnel (
  employee  VARCHAR(8) NOT NULL,
  child1    VARCHAR(8),
  child2    VARCHAR(8),
  child3    VARCHAR(8)
);

INSERT INTO Personnel VALUES
  ('赤井', '一郎', '二郎', '三郎'),
  ('工藤', '春子', '夏子', NULL),
  ('鈴木', '夏子', NULL, NULL),
  ('吉田', NULL, NULL, NULL);


CREATE TABLE TblAge (
  age_class INTEGER NOT NULL,
  age_range VARCHAR(8) NOT NULL
);

INSERT INTO TblAge VALUES
  (1, '21~30歳'),
  (2, '31~40歳'),
  (3, '41~50歳');

CREATE TABLE TblSex (
  sex_cd VARCHAR(4) NOT NULL,
  sex    VARCHAR(4) NOT NULL
);

INSERT INTO TblSex VALUES
  ('m', '男'),
  ('f', '女');

CREATE TABLE TblPop (
  pref_name  VARCHAR(4) NOT NULL,
  age_class  INTEGER    NOT NULL,
  sex_cd     VARCHAR(4) NOT NULL,
  population INTEGER    NOT NULL
);

INSERT INTO TblPop VALUES
  ('秋田', 1, 'm', 400),
  ('秋田', 3, 'm', 1000),
  ('秋田', 1, 'f', 800),
  ('秋田', 3, 'f', 1000),
  ('青森', 1, 'm', 700),
  ('青森', 1, 'f', 500),
  ('青森', 3, 'f', 800),
  ('東京', 1, 'm', 900),
  ('東京', 1, 'f', 1500),
  ('東京', 3, 'f', 1200),
  ('千葉', 1, 'm', 900),
  ('千葉', 1, 'f', 1000),
  ('千葉', 3, 'f', 900);


CREATE TABLE Items (
  item_no INTEGER NOT NULL,
  item    VARCHAR(8) NOT NULL
);

INSERT INTO Items VALUES
  (10, 'SDカード'),
  (20, 'CD-R'),
  (30, 'USBメモリ'),
  (40, 'DVD');

CREATE TABLE SalesHistory (
  sale_date DATE NOT NULL,
  item_no   INTEGER NOT NULL,
  quantity  INTEGER NOT NULL
);

INSERT INTO SalesHistory VALUES
  ('2018-10-01', 10, 4),
  ('2018-10-01', 20, 10),
  ('2018-10-01', 30, 3),
  ('2018-10-03', 10, 32),
  ('2018-10-03', 30, 12),
  ('2018-10-04', 20, 22),
  ('2018-10-04', 30, 7);


CREATE TABLE Class_A (
  id    INTEGER    NOT NULL,
  name  VARCHAR(8) NOT NULL
);

INSERT INTO Class_A VALUES
  (1, '田中'),
  (2, '鈴木'),
  (3, '伊集院');

CREATE TABLE Class_B (
  id    INTEGER    NOT NULL,
  name  VARCHAR(8) NOT NULL
);

INSERT INTO Class_B VALUES
  (1, '田中'),
  (2, '鈴木'),
  (4, '西園寺');
