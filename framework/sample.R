delete_split_table<-strwrap(paste("
drop table 
even_split_android_apple;
"), simplify=T,width=1e5)

create_split_table <- strwrap(paste("
create 
table
even_split_android_apple as (
  select
    distinct(user_id),
    player_start_date,
    case
      when player_start_date BETWEEN '", training_start_date, "' AND ' ", training_end_date,"' then 'training_timeframe'
      when player_start_date BETWEEN '", test_start_date, "' AND ' ", test_end_date,"' then 'test_timeframe'
      else 'other'
    end as signup_timeframe
  from
    measure_v4.fact_user_sessions_day
  where
    environment_id = ", env_id, "
    AND player_start_date BETWEEN '", training_start_date, "' AND ' ", test_end_date,"'
  LIMIT 
    50000
);
  "), simplify=T,width=1e5)
