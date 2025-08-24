with t as (select * from {{ ref('stg_taxi_trips_yellow') }})
select
  t.*,
  extract(epoch from (dropoff_ts - pickup_ts))/60.0 as trip_minutes
from t
where pickup_ts is not null
  and dropoff_ts is not null
  and dropoff_ts >= pickup_ts
  and trip_miles is not null and trip_miles >= 0 and trip_miles <= 200
  and total_amount is not null and total_amount >= -5 and total_amount <= 1000