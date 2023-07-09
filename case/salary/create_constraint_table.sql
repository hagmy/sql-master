CREATE TABLE TestSal
( sex CHAR(1) ,
  salary INTEGER,
    CONSTRAINT check_salary CHECK
                ( CASE WHEN sex = '2'
                    THEN CASE WHEN salary <= 200000
                              THEN 1 ELSE 0 END
                  ELSE 1 END = 1 ));