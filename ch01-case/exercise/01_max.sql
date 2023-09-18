-- x, yの最大値
SELECT key,
  CASE WHEN x < y
    THEN y
    ELSE x
  END AS greatest
FROM Greatests;

-- x, y, zの最大値
SELECT key, MAX(col) AS greatest
  FROM (
    SELECT key, x AS col FROM Greatests
    UNION ALL
    SELECT key, y AS col FROM Greatests
    UNION ALL
    SELECT key, z AS col FROM Greatests
  ) TMP
  GROUP BY key;