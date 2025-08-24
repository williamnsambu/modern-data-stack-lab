with src as (select * from {{ source('raw','taxi_zones') }})
select
  locationid::int as zone_id,
  borough,
  zone,
  service_zone
from src