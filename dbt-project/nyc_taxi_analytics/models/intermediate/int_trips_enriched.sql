with v as (select * from {{ ref('int_trips_validated') }}),
zpu as (select * from {{ ref('stg_taxi_zones') }}),
zdo as (select * from {{ ref('stg_taxi_zones') }})
select
  v.*,
  date_trunc('day', pickup_ts) as pickup_date,
  zpu.borough as pu_borough,
  zpu.zone as pu_zone,
  zdo.borough as do_borough,
  zdo.zone as do_zone,
  case when airport_fee > 0 then true else false end as is_airport_trip,
  case when trip_minutes > 0 then (trip_miles / (trip_minutes/60.0)) end as mph
from v
left join zpu on v.pu_zone_id = zpu.zone_id
left join zdo on v.do_zone_id = zdo.zone_id