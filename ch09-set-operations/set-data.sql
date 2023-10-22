use ch09_set_operations;

CREATE TABLE tblA (
  id    VARCHAR(4)  NOT NULL,
  col1  INTEGER     NOT NULL,
  col2  INTEGER     NOT NULL,
  col3  INTEGER     NOT NULL
);

INSERT INTO tblA VALUES
  ('A', 2, 3, 4),
  ('B', 0, 7, 9),
  ('C', 5, 1, 6);

CREATE TABLE tblB (
  id    VARCHAR(4)  NOT NULL,
  col1  INTEGER     NOT NULL,
  col2  INTEGER     NOT NULL,
  col3  INTEGER     NOT NULL
);

INSERT INTO tblB VALUES
  ('A', 2, 3, 4),
  ('B', 0, 7, 9),
  ('C', 5, 1, 6);


CREATE TABLE Skills (
  skill VARCHAR(8) NOT NULL
);

INSERT INTO Skills VALUES
  ('Oracle'),
  ('UNIX'),
  ('Java');

CREATE TABLE EmpSkills (
  emp   VARCHAR(8)  NOT NULL,
  skill VARCHAR(8)  NOT NULL
);

INSERT INTO EmpSkills VALUES
  ('相田', 'Oracle'),
  ('相田', 'UNIX'),
  ('相田', 'Java'),
  ('相田', 'C#'),
  ('神崎', 'Oracle'),
  ('神崎', 'UNIX'),
  ('神崎', 'Java'),
  ('平井', 'Oracle'),
  ('平井', 'UNIX'),
  ('平井', 'PHP'),
  ('平井', 'Perl'),
  ('平井', 'C++'),
  ('若田部', 'Perl'),
  ('渡来', 'Oracle');


CREATE TABLE SupParts (
  sup   VARCHAR(4)  NOT NULL,
  part  VARCHAR(8)  NOT NULL
);

INSERT INTO SupParts VALUES
  ('A', 'ボルト'),
  ('A', 'ナット'),
  ('A', 'パイプ'),
  ('B', 'ボルト'),
  ('B', 'パイプ'),
  ('C', 'ボルト'),
  ('C', 'ナット'),
  ('C', 'パイプ'),
  ('D', 'ボルト'),
  ('D', 'パイプ'),
  ('E', 'ヒューズ'),
  ('E', 'ナット'),
  ('E', 'パイプ'),
  ('F', 'ヒューズ');


CREATE TABLE Products (
  rowid INTEGER     NOT NULL,
  name  VARCHAR(4)  NOT NULL,
  price INTEGER     NOT NULL
);

INSERT INTO Products VALUES
  (1, 'りんご', 50),
  (2, 'みかん', 100),
  (3, 'みかん', 100),
  (4, 'みかん', 100),
  (5, 'ばなな', 80);
