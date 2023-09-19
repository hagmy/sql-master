CREATE TABLE ClassA (
  name  CHAR(32)  NOT NULL,
  age   INTEGER,
  city  CHAR(32)  NOT NULL
);

INSERT INTO ClassA (
  name,
  age,
  city
) VALUES (
  'ブラウン',
  22,
  '東京'
);

INSERT INTO ClassA (
  name,
  age,
  city
) VALUES (
  'ラリー',
  19,
  '埼玉'
);

INSERT INTO ClassA (
  name,
  age,
  city
) VALUES (
  'ボギー',
  21,
  '千葉'
);

CREATE TABLE ClassB (
  name  CHAR(32)  NOT NULL,
  age   INTEGER,
  city  CHAR(32)  NOT NULL
);

INSERT INTO ClassB (
  name,
  age,
  city
) VALUES (
  '斉藤',
  22,
  '東京'
);

INSERT INTO ClassB (
  name,
  age,
  city
) VALUES (
  '田尻',
  23,
  '東京'
);

INSERT INTO ClassB (
  name,
  city
) VALUES (
  '山田',
  '東京'
);

INSERT INTO ClassB (
  name,
  age,
  city
) VALUES (
  '和泉',
  18,
  '千葉'
);

INSERT INTO ClassB (
  name,
  age,
  city
) VALUES (
  '武田',
  20,
  '千葉'
);

INSERT INTO ClassB (
  name,
  age,
  city
) VALUES (
  '石川',
  19,
  '神奈川'
);
