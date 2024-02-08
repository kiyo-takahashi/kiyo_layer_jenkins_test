select
  time
  ,customer_id
  ,total_price
  ,frequency
  ,last_date
  ,pc_a_flag
  ,pc_b_flag
  ,pc_c_flag
  ,pc_d_flag
  ,pc_e_flag
from
  attribute_summary
where
  (customer_id is null) or
  (frequency is null) or
  (total_price is null) or
  (last_date is null) or
  (pc_a_flag is null) or
  (pc_b_flag is null) or
  (pc_c_flag is null) or
  (pc_d_flag is null) or
  (pc_e_flag is null)
