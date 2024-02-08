WITH A AS
(
  SELECT
    trn.*,
    mst.gender AS gender_a,
    mst.age,
  CASE mst.gender
    WHEN 'M' THEN '男性'
    WHEN 'F' THEN '女性'
    ELSE NULL
  END AS gender,
  CASE
    WHEN mst.age < 20 THEN '10代以下'
    WHEN mst.age < 30 THEN '20代'
    WHEN mst.age < 40 THEN '30代'
    WHEN mst.age < 50 THEN '40代'
    WHEN mst.age < 60 THEN '50代'
    WHEN mst.age < 70 THEN '60代'
    WHEN mst.age >= 70 THEN '70代以上'
    ELSE NULL
  END AS age_range 
  FROM
    kiyo_layer1_sample_db.transaction_pos_header_cleansing trn
  LEFT JOIN kiyo_layer1_sample_db.master_customer_mask mst
         ON trn.customer_id = mst.customer_id
)

SELECT
  gender,
  age_range,
  sum(price) AS total_monetaly,
  count(DISTINCT transaction_id) AS total_freqency
FROM
  a
GROUP BY
  gender,
  age_range
ORDER BY
  gender,
  age_range
