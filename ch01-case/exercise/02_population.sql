SELECT sex,
    SUM(population) AS total,
    SUM(
      CASE WHEN pref_name = '徳島'
        THEN population
        ELSE 0 END
    ) AS tokushima,
    SUM(
      CASE WHEN pref_name = '香川'
        THEN population
        ELSE 0 END
    ) AS kagawa,
    SUM(
      CASE WHEN pref_name = '愛媛'
        THEN population
        ELSE 0 END
    ) AS ehime,
    SUM(
      CASE WHEN pref_name = '高知'
        THEN population
        ELSE 0 END
    ) AS kouchi,
    SUM(
      CASE WHEN pref_name IN('徳島', '香川', '愛媛', '高知')
        THEN population
        ELSE 0 END
    ) AS saikei
  FROM PopTbl2
GROUP BY sex;