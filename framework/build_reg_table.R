#' Build the query for buidling a table using the features selected by the user

deleteOldTable <-strwrap(paste("drop table ", reg_table,";", sep=""), simplify=T,width=1e5)

rebuildTable <- strwrap(paste("
create table ", reg_table, " as (
with sample_data as (
select 
*
from 
even_split_android_apple 
),
sessionFeatures as (
select 
distinct(user_id),
", 
session_features_to_extract
,"
from measure_v4.fact_user_sessions_day
where environment_id=", env_id, "
and player_start_date = event_date
AND player_start_date BETWEEN '", training_start_date, "' AND ' ", test_end_date,"' 
),
firstDay as (
select 
distinct(user_id),
user_country,
",
first_day_sums,
"
from measure_v4.fact_user_sessions_day
where environment_id=", env_id, "
and player_start_date = event_date
AND player_start_date BETWEEN '", training_start_date, "' AND ' ", test_end_date,"'
group by 1, user_country
order by user_id
),
earlyBehaviour as (
SELECT 
distinct(user_id), 
user_country,
",
early_sums,
"
from measure_v4.fact_user_sessions_day 
where environment_id = ", env_id, "
and event_date - player_start_date <= ", early_behaviour_num_days ,"
AND player_start_date BETWEEN '", training_start_date, "' AND ' ", test_end_date,"'
group by user_id, user_country
),
users as (
select 
  distinct(user_id),
  ", 
  user_features_to_extract, 
  ",",
  numeric_summaries, 
  ",
  totalDaysPlayed,
  totalRealCurrencySpent, 
  case
  when totalRealCurrencySpent is null then 'NOT_SPENDER'
  when totalRealCurrencySpent > 0 THEN 'SPENDER'
  else 'unkown'
  end as spender_or_not
from ", user_metrics_table, "
)
SELECT 
  s.user_id,
  s.player_start_date,
  s.signup_timeframe,
  u.totalRealCurrencySpent,
  u.totalDaysPlayed,
  u.spender_or_not,
  r.region,
  ",
  u_user_features_to_extract,
  ",",
  u_numeric_summaries,
  ",",
  o_session_features_to_extract, 
  ", ",
  first_day_extract,
  ",",
  early_extract,
  "
FROM 
  sample_data  as s
  left join users as u
  on s.user_id = u.user_id
  left join sessionFeatures as o 
  on o.user_id = u.user_id
  left join firstDay as f
  on s.user_id = f.user_id
  left join earlyBehaviour as t
  on s.user_id = t.user_id
  left join country_codes_to_region as r
  on f.user_country = r.country_code
)
;
"), simplify=T,width=1e5)
