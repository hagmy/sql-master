use ch05_exists;

-- 欠席者だけを求めるクエリ: 存在量化 (条件 P を満たす x が（少なくとも1つ）存在する)の応用
SELECT DISTINCT M1.meeting, M2.person
  FROM Meetings M1 CROSS JOIN Meetings M2
WHERE NOT EXISTS (
  SELECT * FROM Meetings M3
  WHERE M1.meeting = M3.meeting
  AND M2.person = M3.person
);

-- 欠席者だけを求めるクエリ: 差集合演算の応用
SELECT M1.meeting, M2.person
  FROM Meetings M1, Meetings M2
EXCEPT SELECT meeting, person
  FROM Meetings;

-- 全ての教科が50点以上の生徒 (= 50 点未満の教科が 1 つも存在しない)
SELECT DISTINCT student_id
  FROM TestScores TS1
WHERE NOT EXISTS (
  SELECT * FROM TestScores TS2
  WHERE TS2.student_id = TS1.student_id
  AND TS2.score < 50
);

-- 条件 A: 算数のテストが 80 点以上
SELECT student_id
  FROM TestScores
WHERE subject = '算数' AND score >= 80;

-- 条件 B: 国語のテストが 50 点以上
SELECT student_id
  FROM TestScores
WHERE subject = '国語' AND score >= 50;

-- 条件 A かつ 条件 B
---- 国語のデータが存在しない 400 番の生徒が含まれてしまう
SELECT DISTINCT student_id
  FROM TestScores TS1
WHERE subject IN ('算数', '国語')
AND NOT EXISTS (
  SELECT * FROM TestScores TS2
  WHERE TS2.student_id = TS1.student_id
  AND 1 = CASE
    WHEN subject = '算数' AND score < 80 THEN 1
    WHEN subject = '国語' AND score < 50 THEN 1
    ELSE 0 END
);
---- 400 番の生徒を除く
SELECT student_id
  FROM TestScores TS1
WHERE subject IN ('算数', '国語')
AND NOT EXISTS (
  SELECT * FROM TestScores TS2
  WHERE TS2.student_id = TS1.student_id
  AND 1 = CASE
    WHEN subject = '算数' AND score < 80 THEN 1
    WHEN subject = '国語' AND score < 50 THEN 1
    ELSE 0 END
)
  GROUP BY student_id
HAVING COUNT(*) = 2; -- 必ず 2 教科揃っている


-- 1 番の工程まで完了しているプロジェクト
---- HAVING 句を使用
SELECT project_id FROM Projects
  GROUP BY project_id
  HAVING COUNT(*) = SUM(
    CASE
      WHEN step_nbr <= 1  AND status = '完了' THEN 1
      WHEN step_nbr > 1   AND status = '待機' THEN 1
      ELSE 0 END
  );

---- EXISTS を使用
SELECT * FROM Projects P1
  WHERE NOT EXISTS (
    SELECT status FROM Projects P2
      WHERE P2.project_id = P1.project_id
      AND status <> CASE
        WHEN step_nbr <= 1
          THEN '完了'
          ELSE '待機'
        END
  );
