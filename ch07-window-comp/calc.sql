-- 前年と年少が同じ年度を求める
---- 1. 相関サブクエリの利用
SELECT year, sale FROM Sales S1
  WHERE sale = (
    SELECT sale FROM Sales S2
      WHERE S1.year - 1 = S2.year
  )
  ORDER BY year;
---- 2. ウィンドウ関数の利用
SELECT year, current_sale FROM (
  SELECT year, sale AS current_sale,
    SUM(sale) OVER (
      ORDER BY year RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING
    ) AS pre_sale FROM Sales
) TMP
  WHERE current_sale = pre_sale
  ORDER BY year;

-- 成長、後退、現状維持を一度に求める
---- 1. 相関サブクエリの利用
SELECT year, current_sale AS sale,
  CASE
    WHEN current_sale = pre_sale THEN '→'
    WHEN current_sale > pre_sale THEN '↑'
    WHEN current_sale < pre_sale THEN '↓'
    ELSE '-'
    END AS var
  FROM (
    SELECT year, sale AS current_sale, (
      SELECT sale FROM Sales S2
        WHERE S1.year - 1 = S2.year
    ) AS pre_sale
    FROM Sales S1
  ) TMP
  ORDER BY year;
---- 2. ウィンドウ関数の利用
SELECT year, current_sale,
  CASE
    WHEN current_sale = pre_sale THEN '→'
    WHEN current_sale > pre_sale THEN '↑'
    WHEN current_sale < pre_sale THEN '↓'
    ELSE '-'
    END AS var
  FROM (
    SELECT year, sale AS current_sale,
      SUM(sale) OVER (
        ORDER BY year RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING
      ) AS pre_sale FROM Sales
  ) TMP
  ORDER BY year;


-- 直近の年と同じ年商の年を選択する
---- 1. 相関サブクエリ
SELECT year, sale FROM Sales2 S1
  WHERE sale = (
    SELECT sale FROM Sales2 S2
      WHERE S2.year = (
        SELECT MAX(year) FROM Sales2 S3
          WHERE S1.year > S3.year
      )
  )
  ORDER BY year;
---- 2. ウィンドウ関数
SELECT year, current_sale FROM (
  SELECT year, sale AS current_sale,
    SUM(sale) OVER (
      ORDER BY year ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
    ) AS pre_sale
  FROM Sales2
) TMP
  WHERE current_sale = pre_sale
  ORDER BY year;


-- 各商品分類について平均単価より高い商品を選択する
---- 1. 相関サブクエリ
SELECT genre, name, price FROM Shohin S1
  WHERE price > (
    SELECT AVG(price) FROM Shohin S2
      WHERE S1.genre = S2.genre
      GROUP BY genre
  );
---- 2. ウィンドウ関数
SELECT name, genre, price FROM (
  SELECT name, genre, price,
    AVG(price) OVER (
      PARTITION BY genre
    ) AS avg_price
  FROM Shohin
) TMP
  WHERE price > avg_price;


-- オーバーラップする期間を求める
---- 1. 相関サブクエリ
SELECT reserver, start_date, end_date FROM Reservations R1
  WHERE EXISTS (
    SELECT * FROM Reservations R2
      WHERE R1.reserver <> R2.reserver
        AND (
          R1.start_date BETWEEN R2.start_date AND R2.end_date
          OR
          R1.end_date   BETWEEN R2.start_date AND R2.end_date
        )
  );
---- 2. ウィンドウ関数
SELECT reserver, next_reserver FROM (
  SELECT reserver, start_date, end_date,
    MAX(start_date) OVER (
      ORDER BY start_date ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING
    ) AS next_start_date,
    MAX(reserver) OVER (
      ORDER BY start_date ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING
    ) AS next_reserver
  FROM Reservations
) TMP
  WHERE next_start_date BETWEEN start_date AND end_date;
