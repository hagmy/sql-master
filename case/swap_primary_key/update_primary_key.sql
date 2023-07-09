-- 1. aをワーク用の値dへ変換
UPDATE SomeTable
    SET p_key = 'd'
  WHERE p_key = 'a';

-- 2. bをaへ変換
UPDATE SomeTable
    SET p_key = 'a'
  WHERE p_key = 'b';

-- 3. dをbへ変換
UPDATE SomeTable
    SET p_key = 'b';
  WHERE p_key = 'd';
