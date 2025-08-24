with src as (select * from {{ source('raw','taxi_trips_yellow') }})
select
  vendorid::int                                   as vendor_id,
  nullif(tpep_pickup_datetime,'')::timestamp      as pickup_ts,
  nullif(tpep_dropoff_datetime,'')::timestamp     as dropoff_ts,
  nullif(passenger_count,'')::int                 as passenger_count,
  nullif(trip_distance,'')::numeric               as trip_miles,
  nullif(ratecodeid,'')::int                      as rate_code_id,
  store_and_fwd_flag,
  nullif(pulocationid,'')::int                    as pu_zone_id,
  nullif(dolocationid,'')::int                    as do_zone_id,
  nullif(payment_type,'')::int                    as payment_type,
  nullif(fare_amount,'')::numeric                 as fare_amount,
  nullif(extra,'')::numeric                       as extra,
  nullif(mta_tax,'')::numeric                     as mta_tax,
  nullif(tip_amount,'')::numeric                  as tip_amount,
  nullif(tolls_amount,'')::numeric                as tolls_amount,
  nullif(improvement_surcharge,'')::numeric       as improvement_surcharge,
  nullif(total_amount,'')::numeric                as total_amount,
  nullif(congestion_surcharge,'')::numeric        as congestion_surcharge,
  nullif(airport_fee,'')::numeric                 as airport_fee,
  nullif(cbd_congestion_fee,'')::numeric          as cbd_congestion_fee
from src