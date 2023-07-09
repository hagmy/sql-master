UPDATE TestSal
  SET salary = CASE WHEN salary >= 300000
              THEN salary * 0.9
              WHEN salary >= 250000 AND salary < 280000
              THEN salary * 1.2
            ELSE salary END;
