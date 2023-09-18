-- 順序対
SELECT P1.name AS name_1, P2.name AS name_2
  FROM Products P1 CROSS JOIN Products P2;

-- 非推奨の順序対表示方法
-- SELECT P1.name AS name_1, P2.name AS name_2
--   FROM Products P1, Products P2;

-- 順序対 (同一要素の組み合わせ排除: ON <>)
SELECT P1.name AS name_1, P2.name AS name_2
  FROM Products P1 INNER JOIN Products P2
    ON P1.name <> P2.name;

-- 非順序対 (combination)
SELECT P1.name AS name_1, P2.name AS name_2
  FROM Products P1 INNER JOIN Products P2
    ON P1.name > P2.name;

-- 3つの非順序対
SELECT P1.name AS name_1, P2.name AS name_2, P3.name AS name_3
  FROM Products P1 INNER JOIN Products P2
    ON P1.name > P2.name
      INNER JOIN Products P3
        ON P2.name > P3.name;

-- 値段が同じ商品の組み合わせを取得
SELECT DISTINCT P1.name, P1.price
  FROM Products P1 INNER JOIN Products P2
    ON P1.price = P2.price
    AND P1.name <> P2.name
  ORDER BY P1.price;

-- ランキング算出：ウィンドウ関数の利用
SELECT name, price,
  RANK () OVER (ORDER BY price DESC) AS rank_1,
  DENSE_RANK () OVER (ORDER BY price DESC) AS rank_2
FROM Products;