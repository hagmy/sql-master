-- seq カラムが連番になっているか否か: (最小値) = 1
SELECT '歯抜けあり' AS gap FROM SeqTbl
  HAVING COUNT(*) <> MAX(seq);

-- 歯抜けの最小値を探索
SELECT MIN(seq + 1) AS gap FROM SeqTbl
  WHERE (seq + 1) NOT IN (
    SELECT seq FROM SeqTbl
  );

-- seq カラムが連番になっているか否か: 連続性だけを調べる
SELECT '歯抜けあり' AS gap FROM SeqTbl
  HAVING COUNT(*) <> MAX(seq) - MIN(seq) + 1;


-- income カラムの最頻値を求める
---- ALL 述語を使用
SELECT income, COUNT(*) AS cnt FROM Graduates
  GROUP BY income
  HAVING COUNT(*) >= ALL (
    SELECT COUNT(*) FROM Graduates
      GROUP BY income
  );

---- 極値関数を使用 (NULL と空集合の時は期待する結果が得られない)
SELECT income, COUNT(*) AS cnt FROM Graduates
  GROUP BY income
  HAVING COUNT(*) >= (
    SELECT MAX(cnt) FROM (
      SELECT COUNT(*) AS cnt FROM Graduates
        GROUP BY income
    )
    TMP
  );


-- NULL を含む列に適用した場合、COUNT(*) と COUNT(列名) の結果は異なる
-- (COUNT(*) は NULL を含む行を含むが、COUNT(列名) は NULL を含む行を含まない)
SELECT COUNT(*), COUNT(col_1) FROM NullTbl;


-- 提出日に NULL を含まない学部を選択する
---- COUNT 関数を利用
SELECT dpt FROM Students
  GROUP BY dpt
  HAVING COUNT(*) = COUNT(sbmt_date);
---- CASE 式を利用
SELECT dpt FROM Students
  GROUP BY dpt
  HAVING COUNT(*) = SUM(CASE
    WHEN sbmt_date IS NOT NULL THEN 1
    ELSE 0
    END
  );


-- クラスの 75% 以上の生徒が 80 点以上のクラスを選択
SELECT class FROM TestResults
  GROUP BY class
  HAVING 0.75 * COUNT(*) <= SUM(CASE
    WHEN score >= 80 THEN 1
    ELSE 0
    END
  );

-- 50 点以上を取った生徒のうち、男子の数が女子の数より多いクラスを選択
SELECT class FROM TestResults
  GROUP BY class
  HAVING SUM(CASE
    WHEN score >= 50 AND sex = '男' THEN 1
    ELSE 0
    END
  ) > SUM(CASE
    WHEN score >= 50 AND sex = '女' THEN 1
    ELSE 0
    END
  );

-- 女子の平均点が男子の平均点よりも高いクラスを選択
SELECT class FROM TestResults
  GROUP BY class
  HAVING AVG(CASE
    WHEN sex = '男' THEN score
    ELSE NULL
    END
  ) < AVG(CASE
    WHEN sex = '女' THEN score
    ELSE NULL
    END
  );


-- 全てのメンバーの状態が待機中であるチームを選択
---- 全称文を述語で表現
SELECT team_id, member FROM Teams T1
  WHERE NOT EXISTS(
    SELECT * FROM Teams T2
      WHERE T1.team_id = T2.team_id
        AND status <> '待機'
  );
---- 全称文を集合で表現: 1
SELECT team_id FROM Teams
  GROUP BY team_id
  HAVING COUNT(*) = SUM(CASE
    WHEN status = '待機' THEN 1
    ELSE 0
    END
  );
---- 全称文を集合で表現: 2
SELECT team_id FROM Teams
  GROUP BY team_id
  HAVING MAX(status) = '待機' AND MIN(status) = '待機';

-- 総員スタンバイかどうかをチームごとに一覧表示
SELECT team_id, CASE
  WHEN MAX(status) = '待機' AND MIN(status) = '待機'
    THEN '総員スタンバイ'
    ELSE 'メンバーが足りません'
  END AS status
FROM Teams GROUP BY team_id;


-- 資材のダブっている拠点を選択
SELECT center FROM Materials
  GROUP BY center
  HAVING COUNT(*) <> COUNT(DISTINCT material);

-- 拠点ごとに資材のダブりの有無を一覧表示
SELECT center, CASE
  WHEN COUNT(*) <> COUNT(DISTINCT material)
    THEN 'タブり有り'
    ELSE 'ダブり無し'
  END AS status
FROM Materials GROUP BY center;

-- ダブりのある集合: EXISTS の利用
SELECT DISTINCT center, material FROM Materials M1
  WHERE EXISTS (
    SELECT * FROM Materials M2
      WHERE M1.center = M2.center
        AND M1.receive_date <> M2.receive_date
        AND M1.material = M2.material
  );


-- ビールと紙おむつと自転車を全て置いている店舗を検索: 間違った SQL
-- (IN 述語の条件は「ビールまたは紙おむつまたは自転車を置いている店舗」を意味する)
SELECT DISTINCT shop FROM ShopItems
  WHERE item IN (SELECT item FROM items);

-- ビールと紙おむつと自転車を全て置いている店舗を検索: 正しい SQL
SELECT SI.shop FROM ShopItems SI
  INNER JOIN Items I ON SI.item = I.item
  GROUP BY SI.shop
  HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM items);

-- COUNT(I.item) は 3 とは限らない (ON 句の影響を受けるため)
SELECT SI.shop, COUNT(SI.item), COUNT(I.item) FROM ShopItems SI
  INNER JOIN Items I ON SI.item = I.item
  GROUP BY SI.shop;

-- 厳密な関係除算: 外部結合と COUNT 関数を利用
SELECT SI.shop FROM ShopItems SI LEFT OUTER JOIN Items I ON SI.item = I.item
  GROUP BY SI.shop
  HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM Items)
    AND COUNT(I.item) = (SELECT COUNT(item) FROM Items);
