-- tblA と tblB の行数と一致すれば両者は等しいテーブル
---- 集合が同一なら和集合も同一であるから (S UNION S = S)
SELECT COUNT(*) AS row_cnt FROM (
  SELECT * FROM tblA UNION SELECT * FROM tblB
) TMP;

-- (A UNION B) = (A INTERSECT B) の場合 A = B
---- 常に (A INTERSECT B) ⊆ (A UNION B) が成り立つ
---- 従って (A UNION B) EXCEPT (A INTERSECT B) の結果が空集合かどうか判定をすれば OK
SELECT CASE
  WHEN COUNT(*) = 0 THEN '等しい'
  ELSE '異なる'
  END AS result
FROM (
  (SELECT * FROM tblA UNION SELECT * FROM tblB)
  EXCEPT
  (SELECT * FROM tblA INTERSECT SELECT * FROM tblB)
) TMP;

-- テーブル同士の diff
(SELECT * FROM tblA EXCEPT SELECT * FROM tblB)
UNION ALL
(SELECT * FROM tblB EXCEPT SELECT * FROM tblA);


-- 差集合で関係除算 (剰余を持った除算)
---- 相関サブクエリが空集合なら全部スキルを備えていると言える
SELECT DISTINCT emp FROM EmpSkills ES1
  WHERE NOT EXISTS (
    SELECT skill FROM Skills
    EXCEPT
    SELECT skill FROM EmpSkills ES2 WHERE ES1.emp = ES2.emp
  );


-- 業者の組み合わせを作る
SELECT SP1.sup AS s1, SP2.sup AS s2 FROM SupParts SP1, SupParts SP2
  WHERE SP1.sup < SP2.sup
  GROUP BY SP1.sup, SP2.sup;

-- この業者ペアについて (A ⊆ B) かつ (A ⊇ B) ⇒ (A = B) の公式を当てはめる
---- 以上の式は以下条件と同値
---- 1. どちらの業者も同じ種類の部品を扱っている
---- 2. 同数の部品を扱っている (すなわち全単射が存在)
SELECT SP1.sup AS s1, SP2.sup AS s2 FROM SupParts SP1, SupParts SP2
  WHERE
    SP1.sup < SP2.sup -- 業者の組み合わせを作る
    AND
    SP1.part = SP2.part -- 条件 1
  GROUP BY SP1.sup, SP2.sup
HAVING -- 条件 2
  COUNT(*) = (SELECT COUNT(*) FROM SupParts SP3 WHERE SP3.sup = SP1.sup)
  AND
  COUNT(*) = (SELECT COUNT(*) FROM SupParts SP4 WHERE SP4.sup = SP2.sup);


-- 重複行を削除する
---- 相関サブクエリの利用 (パフォーマンス悪い)
DELETE FROM Products
  WHERE rowid < (
    SELECT MAX(P2.rowid) FROM Products P2
    WHERE
      Products.name = P2.name
      AND
      Products.price = P2.price
  );
---- 補集合を EXCEPT で求める
DELETE FROM Products
  WHERE rowid IN (
    SELECT rowid FROM Products -- 全体の rowid
    EXCEPT
    SELECT MAX(rowid) FROM Products -- 残すべき rowid
    GROUP BY name, price
  );
---- 補集合を NOT IN で求める
DELETE FROM Products
  WHERE rowid NOT IN (
    SELECT MAX(rowid) FROM Products GROUP BY name, price
  );
