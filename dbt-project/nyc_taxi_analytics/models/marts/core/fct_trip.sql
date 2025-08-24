{{ config(
  materialized='incremental',
  unique_key='trip_id',
  on_schema_change='append_new_columns'
) }}

with src as (
  select
    vendor_id,
    pickup_ts,
    dropoff_ts,
    date_trunc('day', pickup_ts) as pickup_date,
    passenger_count,
    trip_miles,
    extract(epoch from (dropoff_ts - pickup_ts))/60.0 as trip_minutes,
    case when extract(epoch from (dropoff_ts - pickup_ts)) > 0
         then trip_miles / (extract(epoch from (dropoff_ts - pickup_ts)) / 3600.0)
    end as mph,
    pu_zone_id, pu_borough, pu_zone,
    do_zone_id, do_borough, do_zone,
    fare_amount, tip_amount, tolls_amount, total_amount,
    is_airport_trip
  from {{ ref('int_trips_enriched') }}
  where pickup_ts is not null and dropoff_ts is not null
  {% if is_incremental() %}
    and pickup_ts > (select coalesce(max(pickup_ts), '1900-01-01') from {{ this }})
  {% endif %}
),
final as (
  select
    md5(
      concat_ws('||',
        coalesce(vendor_id::text,''),
        coalesce(pickup_ts::text,''),
        coalesce(dropoff_ts::text,''),
        coalesce(pu_zone_id::text,''),
        coalesce(do_zone_id::text,''),
        coalesce(total_amount::text,'')
      )
    ) as trip_id,
    *
  from src
)

select * from final