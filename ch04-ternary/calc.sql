-- B クラスの東京在住の生徒と年齢が一致しないA クラスの生徒を選択する SQL
---- 間違い (結果が空: age が NULL であるレコードが ClassB に存在しているため)
SELECT * FROM ClassA
  WHERE age NOT IN (
    SELECT age FROM ClassB
      WHERE city = '東京'
  );

---- 正しい (EXISTS 述語は unknown を返さない: true or false を返す)
SELECT * FROM ClassA A
  WHERE NOT EXISTS (
    SELECT * FROM ClassB B
      WHERE A.age = B.age
      AND B.city = '東京'
  );

-- ↑ IN と EXISTS は同値だが, NOT IN と NOT EXISTS は同値ではない


-- B クラスの東京在住の誰よりも若いA クラスの生徒を選択する
---- NULL がある場合空を返す
SELECT * FROM ClassA
  WHERE age < ALL (
    SELECT age FROM ClassB
      WHERE city = '東京'
  );

---- NULL があるレコードでも値を返す (極値関数が集計の際に NULL を排除する性質を持っているため)
SELECT * FROM ClassA
  WHERE age < (
    SELECT MIN(age) FROM ClassB
      WHERE city = '東京'
  );

-- ALL述語: 彼は東京在住の生徒の誰よりも若い
-- 極値関数: 彼は東京在住の最も若い生徒よりも若い
