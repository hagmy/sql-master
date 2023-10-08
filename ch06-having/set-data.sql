use ch06_having;

CREATE TABLE SeqTbl (
  seq   INTEGER  NOT NULL,
  name  CHAR(32) NOT NULL
);

INSERT INTO SeqTbl VALUES
  (1, 'ディック'),
  (2, 'アン'),
  (3, 'ライル'),
  (5, 'カー'),
  (6, 'マリー'),
  (8, 'ベン');


CREATE TABLE Graduates (
  name    CHAR(32) NOT NULL,
  income  INTEGER  NOT NULL
);

INSERT INTO Graduates VALUES
  ('サンプソン', 400000),
  ('マイク', 30000),
  ('ホワイト', 20000),
  ('アーノルド', 20000),
  ('スミス', 20000),
  ('ロレンス', 15000),
  ('ハドソン', 15000),
  ('ケント', 10000),
  ('ベッカー', 10000),
  ('スコット', 10000);


CREATE TABLE NullTbl (
  col_1  INTEGER
);

INSERT INTO NullTbl VALUES
  (NULL),
  (NULL),
  (NULL);


CREATE TABLE Students (
  student_id  INTEGER  NOT NULL,
  dpt         CHAR(32) NOT NULL,
  sbmt_date   DATE
);

INSERT INTO Students VALUES
  (100, '理学部',  '2018-10-10'),
  (101, '理学部',  '2018-09-22'),
  (102, '文学部',  NULL),
  (103, '文学部',  '2018-09-10'),
  (200, '文学部',  '2018-09-22'),
  (201, '工学部',  NULL),
  (202, '経済学部', '2018-09-25');


CREATE TABLE TestResults (
  student_id  CHAR(3) NOT NULL,
  class       CHAR(1) NOT NULL,
  sex         CHAR(1)  NOT NULL,
  score       INTEGER  NOT NULL
);

INSERT INTO TestResults VALUES
  ('001', 'A', '男', 100),
  ('002', 'A', '女', 100),
  ('003', 'A', '女', 49),
  ('004', 'A', '男', 30),
  ('005', 'B', '女', 100),
  ('006', 'B', '男', 92),
  ('007', 'B', '男', 80),
  ('008', 'B', '男', 80),
  ('009', 'B', '女', 10),
  ('010', 'C', '男', 92),
  ('011', 'C', '男', 80),
  ('012', 'C', '女', 21),
  ('013', 'D', '女', 100),
  ('014', 'D', '女', 0),
  ('015', 'D', '女', 0);


CREATE TABLE Teams (
  member  CHAR(8) NOT NULL,
  team_id INTEGER NOT NULL,
  status  CHAR(8) NOT NULL
);

INSERT INTO Teams VALUES
  ('ジョー', 1, '待機'),
  ('ケン', 1, '出動中'),
  ('ミック', 1, '待機'),
  ('カレン', 2, '出動中'),
  ('キース', 2, '休暇'),
  ('ジャン', 3, '待機'),
  ('ハート', 3, '待機'),
  ('ディック', 3, '待機'),
  ('ベス', 4, '待機'),
  ('アレン', 5, '出動中'),
  ('ロバート', 5, '休暇'),
  ('ケーガン', 5, '待機');


CREATE TABLE Materials (
  center      CHAR(8) NOT NULL,
  receive_date DATE NOT NULL,
  material    CHAR(16) NOT NULL
);

INSERT INTO Materials VALUES
  ('東京', '2018-04-01', '錫'),
  ('東京', '2018-04-12', '亜鉛'),
  ('東京', '2018-05-17', 'アルミニウム'),
  ('東京', '2018-05-20', '亜鉛'),
  ('大阪', '2018-04-20', '銅'),
  ('大阪', '2018-04-22', 'ニッケル'),
  ('大阪', '2018-04-29', '鉛'),
  ('名古屋', '2018-03-15', 'チタン'),
  ('名古屋', '2018-04-01', '炭素鋼'),
  ('名古屋', '2018-04-24', '炭素鋼'),
  ('名古屋', '2018-05-02', 'マグネシウム'),
  ('名古屋', '2018-05-10', 'チタン'),
  ('福岡', '2018-05-10', '亜鉛'),
  ('福岡', '2018-05-28', '錫');


CREATE TABLE Items (
  item  CHAR(8) NOT NULL
);

INSERT INTO Items VALUES
  ('ビール'),
  ('紙おむつ'),
  ('自転車');

CREATE TABLE ShopItems (
  shop  CHAR(4) NOT NULL,
  item  CHAR(8) NOT NULL
);

INSERT INTO ShopItems VALUES
  ('仙台', 'ビール'),
  ('仙台', '紙おむつ'),
  ('仙台', '自転車'),
  ('仙台', 'カーテン'),
  ('東京', 'ビール'),
  ('東京', '紙おむつ'),
  ('東京', '自転車'),
  ('大阪', 'テレビ'),
  ('大阪', '紙おむつ'),
  ('大阪', '自転車');
