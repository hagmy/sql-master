-- 連番を求める
---- 0-99
SELECT D1.digit + (D2.digit * 10) AS seq
  FROM Digits D1 CROSS JOIN Digits D2
ORDER BY seq;
---- 1~542
SELECT D1.digit + (D2.digit * 10) + (D3.digit * 100) AS seq
  FROM Digits D1 CROSS JOIN Digits D2 CROSS JOIN Digits D3
  WHERE D1.digit + (D2.digit * 10) + (D3.digit * 100) BETWEEN 1 AND 542
ORDER BY seq;

-- シーケンスビュー作成: 0-999
CREATE VIEW Sequence (seq) AS
  SELECT D1.digit + (D2.digit * 10) + (D3.digit * 100)
  FROM Digits D1 CROSS JOIN Digits D2 CROSS JOIN Digits D3;

-- シーケンスビューから 1-100 を取得
SELECT seq FROM Sequence
  WHERE seq BETWEEN 1 AND 100
ORDER BY seq;

-- 欠番を全て求める
---- EXCEPT バージョン
SELECT seq FROM Sequence
  WHERE seq BETWEEN 1 AND 12
EXCEPT
  SELECT seq FROM SeqTbl
ORDER BY seq;
---- NOT IN バージョン
SELECT seq FROM Sequence
  WHERE
    seq BETWEEN 1 AND 12
  AND
    seq NOT IN (SELECT seq FROM SeqTbl)
ORDER BY seq;

-- 連番の範囲を動的に決定するクエリ
SELECT seq FROM Sequence
  WHERE seq BETWEEN (SELECT MIN(seq) FROM SeqTbl ST1) AND (SELECT MAX(seq) FROM SeqTbl)
EXCEPT
  SELECT seq FROM SeqTbl
ORDER BY seq;


-- 連続する 3 個の空席を見つける
---- NOT EXISTS バージョン
SELECT S1.seat AS start_seat, '~', S2.seat AS end_seat
  FROM Seats S1, Seats S2
  WHERE
    S2.seat = S1.seat + 2
  AND
    NOT EXISTS (
      SELECT * FROM Seats S3
        WHERE
          S3.seat BETWEEN S1.seat AND S2.seat
        AND
          S3.status = 1
    );
---- ウィンドウ関数バージョン
SELECT seat, '~', seat + 2
  FROM (
    SELECT
      seat,
      MAX(seat) OVER(
        ORDER BY seat
        ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING
      ) AS end_seat
    FROM Seats
    WHERE status = 0
  ) TMP
  WHERE end_seat - seat = 2;

-- 折り返しを考慮して連続する 3 個の空席を見つける
---- NOT EXISTS バージョン
SELECT S1.seat AS start_seat, '~', S2.seat AS end_seat
  FROM Seats2 S1, Seats2 S2
  WHERE
    S2.seat = S1.seat + 2
  AND
    NOT EXISTS(
      SELECT * FROM Seats2 S3
      WHERE
        S3.seat BETWEEN S1.seat AND S2.seat
      AND
        (S3.status = 1 OR S3.line_id <> S1.line_id)
    );
---- ウィンドウ関数バージョン
SELECT seat, '~', seat + 2
  FROM (
    SELECT
      seat,
      MAX(seat) OVER (
        PARTITION BY line_id
        ORDER BY seat
        ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING
      ) AS end_seat
    FROM Seats2
    WHERE status = 0
  ) TMP
  WHERE end_seat - seat = 2;


-- 前回から上昇したかどうか
SELECT
  deal_date,
  price,
  CASE SIGN( -- SIGN 関数は数値を引数に取り、符号が正ならば 1, 0 ならば 0, 負ならば -1 を返す
    price - MAX(price) OVER(
      ORDER BY deal_date
      ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
    )
  )
    WHEN 1  THEN 'up'
    WHEN 0  THEN 'stay'
    WHEN -1 THEN 'down'
    ELSE NULL
  END AS diff
FROM MyStock;

-- up のレコードだけに限定したビューを作成
CREATE VIEW MyStockUpSeq(deal_date, price, row_num) AS
  SELECT
    deal_date,
    price,
    row_num
  FROM (
    SELECT
      deal_date,
      price,
      CASE SIGN(
        price - MAX(price) OVER(
          ORDER BY deal_date
          ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
        )
      )
        WHEN 1  THEN 'up'
        WHEN 0  THEN 'stay'
        WHEN -1 THEN 'down'
        ELSE NULL
      END AS diff,
      ROW_NUMBER() OVER(ORDER BY deal_date) AS row_num
    FROM MyStock
  ) TMP
  WHERE diff = 'up';

-- 自己結合でシーケンスをグループ化
SELECT MIN(deal_date) AS start_date, '~', MAX(deal_date) AS end_date
FROM (
  SELECT M1.deal_date, MIN(M1.row_num) - COUNT(M2.row_num) AS gap
  FROM MyStockUpSeq M1 INNER JOIN MyStockUpSeq M2
    ON M2.row_num <= M1.row_num
  GROUP BY M1.deal_date
) TMP
GROUP BY gap;
