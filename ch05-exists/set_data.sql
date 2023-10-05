CREATE TABLE Meetings (
  meeting  CHAR(32) NOT NULL,
  person   CHAR(32) NOT NULL
);

INSERT INTO Meetings VALUES ('第1回', '伊藤');
INSERT INTO Meetings VALUES ('第1回', '水島');
INSERT INTO Meetings VALUES ('第1回', '坂東');
INSERT INTO Meetings VALUES ('第2回', '伊藤');
INSERT INTO Meetings VALUES ('第2回', '宮田');
INSERT INTO Meetings VALUES ('第3回', '坂東');
INSERT INTO Meetings VALUES ('第3回', '水島');
INSERT INTO Meetings VALUES ('第3回', '伊藤');


CREATE TABLE TestScores (
  student_id  INTEGER   NOT NULL,
  subject     CHAR(32)  NOT NULL,
  score       INTEGER   NOT NULL
);

INSERT INTO TestScores VALUES (100, '算数', 100);
INSERT INTO TestScores VALUES (100, '国語', 80);
INSERT INTO TestScores VALUES (100, '理科', 80);
INSERT INTO TestScores VALUES (200, '算数', 80);
INSERT INTO TestScores VALUES (200, '国語', 95);
INSERT INTO TestScores VALUES (300, '算数', 40);
INSERT INTO TestScores VALUES (300, '国語', 90);
INSERT INTO TestScores VALUES (300, '社会', 55);
INSERT INTO TestScores VALUES (400, '算数', 80);


CREATE TABLE Projects (
  project_id  CHAR(32)  NOT NULL,
  step_nbr    INTEGER   NOT NULL,
  status      CHAR(32)  NOT NULL
);

INSERT INTO Projects VALUES ('AA100', 0, '完了');
INSERT INTO Projects VALUES ('AA100', 1, '待機');
INSERT INTO Projects VALUES ('AA100', 2, '待機');
INSERT INTO Projects VALUES ('B200',  0, '待機');
INSERT INTO Projects VALUES ('B200',  1, '待機');
INSERT INTO Projects VALUES ('CS300', 0, '完了');
INSERT INTO Projects VALUES ('CS300', 1, '完了');
INSERT INTO Projects VALUES ('CS300', 2, '待機');
INSERT INTO Projects VALUES ('CS300', 3, '待機');
INSERT INTO Projects VALUES ('DY400', 0, '完了');
INSERT INTO Projects VALUES ('DY400', 1, '完了');
INSERT INTO Projects VALUES ('DY400', 2, '完了');
