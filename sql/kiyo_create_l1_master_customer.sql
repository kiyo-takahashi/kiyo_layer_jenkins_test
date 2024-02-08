SELECT
  customer_id,
  registration_date AS registration_datetime,
  SUBSTRING(registration_date,1,10) AS registration_date,
  SUBSTRING(registration_date,12,99) AS registration_time,
  gender,
  age,
  SUBSTRING(birth, 6, 2) AS birthday_month,
  TO_HEX(SHA256(TO_UTF8(email))) AS email_hash
FROM
  master_customer