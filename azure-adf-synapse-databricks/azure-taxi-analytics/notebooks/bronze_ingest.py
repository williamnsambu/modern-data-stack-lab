import argparse, os
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DoubleType

p = argparse.ArgumentParser()
p.add_argument("--source", choices=["file","eventhub"], default="file")
p.add_argument("--land",   default="./_local_stream/landing")
p.add_argument("--bronze", default="./_lake/bronze/taxi_events")
args = p.parse_args()

spark = (SparkSession.builder.appName("bronze_ingest").getOrCreate())

schema = StructType([
    StructField("ride_id", StringType()),
    StructField("vendor", StringType()),
    StructField("pickup_ts", StringType()),
    StructField("dropoff_ts", StringType()),
    StructField("pickup_zone", StringType()),
    StructField("dropoff_zone", StringType()),
    StructField("passengers", IntegerType()),
    StructField("fare_amount", DoubleType()),
    StructField("tip_amount", DoubleType()),
])

if args.source == "file":
    # Standard JSON streaming in OSS Spark
    df = (spark.readStream
          .format("json")
          .schema(schema)
          .load(args.land))
else:
    # Placeholder for Event Hubs (use Databricks for this mode)
    raise RuntimeError("Event Hubs streaming requires Databricks runtime. Use --source file for local demo.")

query = (df.writeStream
         .format("delta")
         .option("checkpointLocation", args.bronze + "/_checkpoint")
         .outputMode("append")
         .start(args.bronze))

query.awaitTermination()
