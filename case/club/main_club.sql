-- 条件1: 1つのクラブに専念している学生を選択
SELECT std_id, MAX(club_id) AS main_club
    FROM StudentClub
    GROUP BY std_id
    HAVING COUNT(*) = 1;

-- 条件2: クラブを掛け持ちしている学生を選択
SELECT std_id, club_id AS main_club
    FROM StudentClub
    WHERE main_club_flg = 'Y';