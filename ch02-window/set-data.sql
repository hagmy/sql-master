CREATE TABLE server_load_sample (
  server       CHAR(32) NOT NULL,
  sample_date  DATE     NOT NULL,
  load_val     INTEGER  NOT NULL
);

INSERT INTO server_load_sample VALUES ('A', '2018-02-01', 1024);
INSERT INTO server_load_sample VALUES ('A', '2018-02-02', 2366);
INSERT INTO server_load_sample VALUES ('A', '2018-02-05', 2366);
INSERT INTO server_load_sample VALUES ('A', '2018-02-07', 985);
INSERT INTO server_load_sample VALUES ('A', '2018-02-08', 780);
INSERT INTO server_load_sample VALUES ('A', '2018-02-12', 1000);
INSERT INTO server_load_sample VALUES ('B', '2018-02-01', 54);
INSERT INTO server_load_sample VALUES ('B', '2018-02-02', 39008);
INSERT INTO server_load_sample VALUES ('B', '2018-02-03', 2900);
INSERT INTO server_load_sample VALUES ('B', '2018-02-04', 556);
INSERT INTO server_load_sample VALUES ('B', '2018-02-05', 12600);
INSERT INTO server_load_sample VALUES ('B', '2018-02-06', 7309);
INSERT INTO server_load_sample VALUES ('C', '2018-02-01', 1000);
INSERT INTO server_load_sample VALUES ('C', '2018-02-07', 2000);
INSERT INTO server_load_sample VALUES ('C', '2018-02-16', 500);
