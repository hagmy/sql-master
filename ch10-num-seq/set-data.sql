CREATE TABLE Digits (
  digit INTEGER NOT NULL
);

INSERT INTO Digits VALUES
  (0),
  (1),
  (2),
  (3),
  (4),
  (5),
  (6),
  (7),
  (8),
  (9);

CREATE TABLE SeqTbl (
  seq INTEGER NOT NULL
);

INSERT INTO SeqTbl VALUES
  (1),
  (2),
  (4),
  (5),
  (6),
  (7),
  (8),
  (11),
  (12);


CREATE TABLE Seats (
  seat    INTEGER NOT NULL,
  status  BOOLEAN NOT NULL COMMENT '0: 空, 1: 占'
);

INSERT INTO Seats VALUES
  (1, 1),
  (2, 1),
  (3, 0),
  (4, 0),
  (5, 0),
  (6, 1),
  (7, 0),
  (8, 0),
  (9, 0),
  (10, 0),
  (11, 0),
  (12, 1),
  (13, 1),
  (14, 0),
  (15, 0);

CREATE TABLE Seats2 (
  seat    INTEGER     NOT NULL,
  line_id VARCHAR(4)  NOT NULL,
  status  BOOLEAN     NOT NULL COMMENT '0: 空, 1: 占'
);

INSERT INTO Seats2 VALUES
  (1, 'A', 1),
  (2, 'A', 1),
  (3, 'A', 0),
  (4, 'A', 0),
  (5, 'A', 0),
  (6, 'B', 1),
  (7, 'B', 1),
  (8, 'B', 0),
  (9, 'B', 0),
  (10, 'B', 0),
  (11, 'C', 0),
  (12, 'C', 0),
  (13, 'C', 0),
  (14, 'C', 1),
  (15, 'C', 0);


CREATE TABLE MyStock (
  deal_date DATE    NOT NULL,
  price     INTEGER NOT NULL
);

INSERT INTO MyStock VALUES
  ('2018-01-06', 1000),
  ('2018-01-08', 1050),
  ('2018-01-09', 1050),
  ('2018-01-12', 900),
  ('2018-01-13', 880),
  ('2018-01-14', 870),
  ('2018-01-16', 920),
  ('2018-01-17', 1000),
  ('2018-01-18', 2000);
