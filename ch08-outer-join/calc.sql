-- クロス表を求める水平展開
---- 外部結合の利用 (変更しにくいが、パフォーマンスは良い)
SELECT C0.name,
  CASE WHEN C1.name IS NOT NULL THEN '〇' ELSE NULL END AS 'SQL入門',
  CASE WHEN C2.name IS NOT NULL THEN '〇' ELSE NULL END AS 'UNIX基礎',
  CASE WHEN C3.name IS NOT NULL THEN '〇' ELSE NULL END AS 'Java中級'
  FROM (SELECT DISTINCT name FROM Courses) C0
  LEFT OUTER JOIN (SELECT name FROM Courses WHERE course = 'SQL入門') C1
    ON C0.name = C1.name
  LEFT OUTER JOIN (SELECT name FROM Courses WHERE course = 'UNIX基礎') C2
    ON C0.name = C2.name
  LEFT OUTER JOIN (SELECT name FROM Courses WHERE course = 'Java中級') C3
    ON C0.name = C3.name;
---- スカラサブクエリの利用 (変更しやすいが、パフォーマンスが悪い)
SELECT C0.name,
  (SELECT '〇' FROM Courses C1 WHERE course = 'SQL入門' AND C1.name = C0.name) AS 'SQL入門',
  (SELECT '〇' FROM Courses C2 WHERE course = 'UNIX基礎' AND C2.name = C0.name) AS 'UNIX基礎',
  (SELECT '〇' FROM Courses C3 WHERE course = 'Java中級' AND C3.name = C0.name) AS 'Java中級'
FROM (SELECT DISTINCT name FROM Courses) C0;
-- CASE 式を入れ子にする
SELECT name,
  CASE
    WHEN SUM(CASE WHEN course = 'SQL入門' THEN 1 ELSE NULL END) = 1
    THEN '〇'
    ELSE NULL
    END AS 'SQL入門',
  CASE
    WHEN SUM(CASE WHEN course = 'UNIX基礎' THEN 1 ELSE NULL END) = 1
    THEN '〇'
    ELSE NULL
    END AS 'UNIX基礎',
  CASE
    WHEN SUM(CASE WHEN course = 'Java中級' THEN 1 ELSE NULL END) = 1
    THEN '〇'
    ELSE NULL
    END AS 'Java中級'
FROM Courses
GROUP BY name;


-- 列から行への変換
SELECT employee, child1 AS child FROM Personnel
UNION ALL
SELECT employee, child2 AS child FROM Personnel
UNION ALL
SELECT employee, child3 AS child FROM Personnel
ORDER BY employee;

-- 子どもの一覧を作成
CREATE VIEW Children(child) AS
  SELECT child1 FROM Personnel
  UNION
  SELECT child2 FROM Personnel
  UNION
  SELECT child3 FROM Personnel;

-- 社員の子ども
SELECT EMP.employee, Children.child FROM Personnel EMP
  LEFT OUTER JOIN Children
    ON Children.child IN (EMP.child1, EMP.child2, EMP.child3);


-- 外部結合で入れ子の表側を作成
---- 間違った SQL (年齢階級 2 の行が現れない)
SELECT MASTER1.age_class AS age_class, MASTER2.sex_cd AS sex_cd, DATA.pop_tohoku AS pop_tohoku, DATA.pop_kanto AS pop_kanto
FROM (
  SELECT age_class, sex_cd,
    SUM(CASE WHEN pref_name IN ('青森', '秋田') THEN population ELSE NULL END) AS pop_tohoku,
    SUM(CASE WHEN pref_name IN ('東京', '千葉') THEN population ELSE NULL END) AS pop_kanto
  FROM TblPop
  GROUP BY age_class, sex_cd
) DATA
RIGHT OUTER JOIN TblAge MASTER1 ON MASTER1.age_class = DATA.age_class
RIGHT OUTER JOIN TblSex MASTER2 ON MASTER2.sex_cd = DATA.sex_cd;
---- 最初の外部結合で止めた場合、年齢階級 2 も結果に現れる
SELECT MASTER1.age_class AS age_class, DATA.pop_tohoku AS pop_tohoku, DATA.pop_kanto AS pop_kanto
FROM (
  SELECT age_class, sex_cd,
    SUM(CASE WHEN pref_name IN ('青森', '秋田') THEN population ELSE NULL END) AS pop_tohoku,
    SUM(CASE WHEN pref_name IN ('東京', '千葉') THEN population ELSE NULL END) AS pop_kanto
  FROM TblPop
  GROUP BY age_class, sex_cd
) DATA
RIGHT OUTER JOIN TblAge MASTER1 ON MASTER1.age_class = DATA.age_class;
------ ON MASTER2.sex_cd = NULL となり、結果は unknown となるため
---- 正しい SQL
SELECT MASTER.age_class AS age_class, MASTER.sex_cd AS sex_cd, DATA.pop_tohoku AS pop_tohoku, DATA.pop_kanto AS pop_kanto
FROM (SELECT age_class, sex_cd FROM TblAge CROSS JOIN TblSex) MASTER
LEFT OUTER JOIN (
  SELECT age_class, sex_cd,
    SUM(CASE WHEN pref_name IN ('青森', '秋田') THEN population ELSE NULL END) AS pop_tohoku,
    SUM(CASE WHEN pref_name IN ('東京', '千葉') THEN population ELSE NULL END) AS pop_kanto
  FROM TblPop
  GROUP BY age_class, sex_cd
) DATA
ON MASTER.age_class = DATA.age_class AND MASTER.sex_cd = DATA.sex_cd;


-- 商品ごとに総計でいくつ売れたかを取得
---- 1. 結合の前に集約することで、一対一の関係を作成する
---- (中間ビュー SH のデータを一度メモリ上に保持する必要があるのでパフォーマンスの観点で課題あり)
SELECT I.item_no, SH.total_qty FROM Items I
LEFT OUTER JOIN (
  SELECT item_no, SUM(quantity) AS total_qty FROM SalesHistory
  GROUP BY item_no
) SH
ON I.item_no = SH.item_no;

---- 2. 集約の前に一対多の結合を行う
SELECT I.item_no, SUM(SH.quantity) AS total_qty FROM Items I
LEFT OUTER JOIN SalesHistory SH
ON I.item_no = SH.item_no
GROUP BY I.item_no;


-- 完全外部結合は情報を「完全」に保存する (FULL OUTER JOIN は MySQL にはない)
SELECT COALESCE(A.id, B.id) AS id, A.name AS A_name, B.name AS B_name
FROM Class_A A
FULL OUTER JOIN Class_B B ON A.id = B.id;

-- 完全外部結合が使えない環境での代替方法
---- 冗長かつ結合を 2 回繰り返した上に UNION で結合するためパフォーマンスが悪い
SELECT A.id AS id, A.name, B.name FROM Class_A A
LEFT OUTER JOIN Class_B B ON A.id = B.id
UNION
SELECT B.id AS id, A.name, B.name FROM Class_A A
RIGHT OUTER JOIN Class_B B ON A.id = B.id;

-- 外部結合で差集合を求める
---- A - B
SELECT A.id AS id, A.name AS A_name FROM Class_A A
LEFT OUTER JOIN Class_B B ON A.id = B.id
WHERE B.name IS NULL;
---- B - A
SELECT B.id AS id, B.name AS B_name FROM Class_B B
LEFT OUTER JOIN Class_A A ON A.id = B.id
WHERE A.name IS NULL;
