SELECT
  transaction_id,
  price,
  payment_date AS payment_datetime,
  SUBSTRING( payment_date,1,10) AS  payment_date,
  SUBSTRING( payment_date,12,99) AS  payment_time,
  customer_id
FROM
  transaction_pos_header
WHERE
  cancel_flag = 0