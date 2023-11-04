use ch11_perform;

CREATE TABLE ClassA (
  id    INTEGER     NOT NULL,
  name  VARCHAR(8)  NOT NULL
);

INSERT INTO ClassA VALUES
  (1, '田中'),
  (2, '鈴木'),
  (3, '伊集院');

CREATE TABLE ClassB (
  id    INTEGER     NOT NULL,
  name  VARCHAR(8)  NOT NULL
);

INSERT INTO ClassB VALUES
  (1, '田中'),
  (2, '鈴木'),
  (4, '西園寺');


CREATE TABLE Items (
  item_no INTEGER     NOT NULL,
  item    VARCHAR(8)  NOT NULL
);

INSERT INTO Items VALUES
  (10, 'SDカード'),
  (20, 'CD-R'),
  (30, 'USBメモリ'),
  (40, 'DVD');

CREATE TABLE SalesHistory (
  sale_date DATE    NOT NULL,
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
