with
  t1 as (
    select
      a.*
    , item_name
    , item_price
    from
      transaction_pos_detail a
      left join master_item b on a.item_id = b.item_id
  )
, t2 as (
    select
      a.*
    , item_id
    , item_name
    , item_price
    , quantity
    from
      transaction_pos_header a
      left join t1 b on a.transaction_id = b.transaction_id
  )
, t3 as (
    select
      *
    , IF (
        cancel_flag = 0
      , item_price * quantity
      , item_price * quantity * -1
      ) as unit_price
    , IF (item_name = 'PC-A', '1', '0') as pc_a_flag
    , IF (item_name = 'PC-B', '1', '0') as pc_b_flag
    , IF (item_name = 'PC-C', '1', '0') as pc_c_flag
    , IF (item_name = 'PC-D', '1', '0') as pc_d_flag
    , IF (item_name = 'PC-E', '1', '0') as pc_e_flag
    from
      t2
  )
select
  customer_id
, sum(unit_price) as total_price
, count(distinct transaction_id) as frequency
, max(substring(payment_date, 1, 10)) as last_date
, pc_a_flag
, pc_b_flag
, pc_c_flag
, pc_d_flag
, pc_e_flag
from
  t3
group by
  customer_id
, pc_a_flag
, pc_b_flag
, pc_c_flag
, pc_d_flag
, pc_e_flag