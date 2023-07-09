-- population of male
SELECT pref_name, population FROM Poptbl2 WHERE sex = '1';

-- population of female
SELECT pref_name, population FROM Poptbl2 WHERE sex = '2';

SELECT pref_name,
    -- population of male
    SUM( CASE WHEN sex = '1' THEN population ELSE 0 END ) AS cnt_m,
    -- population of female
    SUM( CASE WHEN sex = '2' THEN population ELSE 0 END ) AS cnt_f
  FROM Poptbl2
GROUP BY pref_name;