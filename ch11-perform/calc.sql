-- 【効率の良い検索】

---- IN: 遅いが可読性が高い
---- リストではなくサブクエリを引数に取る場合パフォーマンスが下がる
SELECT * FROM ClassA
  WHERE id IN (SELECT id FROM ClassB);

---- EXISTS: 速いが可読性が低い
---- 1. 結合キー (この場合 id) にインデックスが張られていれば ClassB の実表は見に行かずインデックスを参照するのみで済む
---- 2. EXISTS は 1 行でも条件に合致する行を見つけたらそこで検索を打ち切るため IN のように全表検索の必要がない (NOT EXISTS でも同様)
SELECT * FROM ClassA A
  WHERE EXISTS (
    SELECT * FROM ClassB B
      WHERE A.id = B.id
  );

---- 結合: IN のパフォーマンスは改善されるが EXISTS とどちらが優れているかは微妙
---- インデックスがない場合は恐らく EXISTS に軍配が上がる
---- 結合よりは EXISTS を使う方が好ましいケースもある
SELECT A.id, A.name
  FROM ClassA A
    INNER JOIN ClassB B ON A.id = B.id;


-- 【ソートを回避する】
-- ソートがメモリ上で行われている間はまだ良いがそれでは足りずにストレージを使ったソートが行われるとパフォーマンスは大きく低下する
-- 以下はソートが発生する代表的な演算
-- * GROUP BY 句
-- * ORDER BY 句
-- * 集約関数 (SUM, COUNT, AVG, MAX, MIN)
-- * DISTINCT
-- * 集合演算子 (UNION, INTERSECT, EXCEPT)
-- * ウィンドウ関数 (RANK, ROW_NUMBER 等)

-- 集合演算子は普通に使用すると必ず重複排除のためのソートを行う
SELECT * FROM ClassA
UNION
SELECT * FROM ClassB;

-- 重複を気にしなくて良い場合 or 重複が発生しないことが明らかな場合
-- UNION の代わりに UNION ALL を使用する (ソートは発生しない: INTERSECT, EXCEPT も同様)
SELECT * FROM ClassA
INTERSECT ALL
SELECT * FROM ClassB;


-- 【DISTINCT を EXISTS で代用】
-- DISTINCT は重複排除のためのソートを行う
-- 2 つのテーブルを結合した結果を一意にするために DISTINCT を使用するケースでは
-- EXISTS で代用することでソートを回避することができる

-- Items から　SalesHistory に存在する商品を選択する
-- 1:N のため 重複が発生する
SELECT I.item_no FROM Items I
  INNER JOIN SalesHistory SH
    ON I.item_no = SH.item_no;

-- DISTINCT を使用して重複排除
SELECT DISTINCT I.item_no FROM Items I
  INNER JOIN SalesHistory SH
    ON I.item_no = SH.item_no;

-- 最適解は EXISTS を使用すること (ソートは発生しない)
SELECT item_no FROM Items I
  WHERE EXISTS (
    SELECT * FROM SalesHistory SH
      WHERE I.item_no = SH.item_no
  );


-- 【極値関数 (MIN, MAX) でインデックスを使用】
-- 極値関数はソートを発生させるが引数の列にインデックスが存在する場合
-- そのインデックスのスキャンだけで済み、実表への検索を回避できる

-- 全表検索が必要
SELECT MAX(item) FROM items;

-- インデックスを利用できる
SELECT MAX(item_no) FROM items;


-- 【WHERE 句で書ける条件は HAVING 句には書かない】
-- 1. GROUP BY 句による集約はソートやハッシュの演算を行うため事前に行数を絞りんだ方がソート負荷が軽減される
-- 2. 上手くいけば WHERE 句の条件でインデックスを利用できる

-- 集約した後に HAVING 句でフィルタリング
SELECT sale_date, SUM(quantity) FROM SalesHistory
GROUP BY sale_date
  HAVING sale_date = '2018-10-01';

-- 集約する前に WHERE 句でフィルタリング (効率が良い)
SELECT sale_date, SUM(quantity) FROM SalesHistory
  WHERE sale_date = '2018-10-01'
GROUP BY sale_date;


-- 【インデックスが使用されない場合】

-- * 索引列に加工を行っている場合
SELECT * FROM SomeTable WHERE col1 * 1.1 > 100;
---- 右式に用いればインデックスが使用される
SELECT * FROM SomeTable WHERE col1 > 100 / 1.1;

-- * インデックス列に NULL が存在する場合
SELECT * FROM SomeTable WHERE col1 IS NULL;

-- * 否定系を使用している場合 (<>, !=, NOT IN)
SELECT * FROM SomeTable WHERE col1  <> 100;

-- * OR を使用する場合
-- col1, col2 別々のインデックスがある場合や (col1, col2) に複合インデックスを張っている場合のいずれもインデックスは使用されない
SELECT * FROM SomeTable WHERE col1 > 100 OR col2 = 'abc';

-- * 複合索引の場合に列の順番を間違えている場合
-- (col1, col2, col3) に対してこの順番で複合インデックスが張られている場合必ず先頭が col1 でなければならなく順番も崩してはいけない
-- OK
SELECT * FROM SomeTable WHERE col1 = 10 AND col2 = 100 AND col3 = 500;
-- OK
SELECT * FROM SomeTable WHERE col1 = 10 AND col2 = 100;
-- NG
SELECT * FROM SomeTable WHERE col1 = 10 AND col3 = 500;
-- NG
SELECT * FROM SomeTable WHERE col2 = 100 AND col3 = 500;

-- * 後方一致 or 中間一致の LIKE 述語を使用している場合
-- OK
SELECT * FROM SomeTable WHERE col1 LIKE 'a%';
-- NG
SELECT * FROM SomeTable WHERE col1 LIKE '%a';
-- NG
SELECT * FROM SomeTable WHERE col1 LIKE '%a%';

-- 暗黙の型変換を行っている場合
-- OK
SELECT * FROM SomeTable WHERE col1 = 10;
-- OK
SELECT * FROM SomeTable WHERE col1 = '10';
-- NG
SELECT * FROM SomeTable WHERE col1 = CAST(10, AS CHAR(2));


-- 【中間テーブルを減らせ】
-- 中間テーブルの問題点は
-- 1. データを展開するためにメモリ (場合によってはストレージ) を消費すること
-- 2. 元テーブルに存在したインデックスを使うのが難しくなる (特に集約した場合)
-- 以上から可能な限り無駄な中間テーブルを省くことがパフォーマンス向上の鍵となる

-- 日毎の最大売上個数を取得
---- サブクエリの利用 (非効率)
SELECT * FROM (
  SELECT sale_date, MAX(quantity) AS max_qty
    FROM SalesHistory
  GROUP BY sale_date
) TMP -- 無駄な中間テーブル
  WHERE max_qty >= 10;
---- HAVING 句の活用
------ 集約を行いながら並行して動作するため中間テーブルの作成後に実行される WHERE 句よりも効率的
SELECT sale_date, MAX(quantity)
  FROM SalesHistory
GROUP By sale_date
  HAVING MAX(quantity) >= 10;

-- IN 述語で複数のキーを利用する場合は一箇所にまとめる
---- NG: サブクエリを 2 つ使用しているため非効率
SELECT id, state, city FROM Addresses1 A1
  WHERE
    state IN (
      SELECT state FROM Addresses2 A2
        WHERE A1.id = A2.id
    )
  AND
    city IN (
      SELECT city FROM Addresses2 A2
        WHERE A1.id = A2.id
    );
-- OK
SELECT * FROM Addresses1 A1
  WHERE id || state || city IN (
    SELECT id || state || city FROM Addresses2 A2
  );
-- OK: 行比較をサポートしている DB の場合使用できる
SELECT * FROM Addresses1 A1
  WHERE (id, state, city) IN (
    SELECT id, state, city FROM Addresses2 A2
  );


-- 【集約よりも結合を先に行う】
-- 結合と集約を併用するケースでは、集約よりも結合を先に行うことで中間テーブルを省略できる
-- (集合演算としての結合が掛け算として機能するため)
