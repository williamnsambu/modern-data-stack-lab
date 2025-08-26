# Modern Data Stack Lab

A collection of end-to-end data engineering and analytics projects showcasing skills in dbt, Databricks, Azure, and modern data stack tools. Each project demonstrates solving a real-world problem with production-grade practices.

⸻

Projects

1. NYC Taxi Analytics (dbt + Postgres)

Tech: dbt, PostgreSQL, GitHub Actions (optional CI), VS Code Power User extension

	•	Problem: NYC taxi data is large and messy (millions of rows, multiple schemas).
	•	Goal: Transform raw taxi trips into clean, analytics-ready marts for insights like revenue, trip volume, and airport traffic.
	•	Highlights:
	•	Staging → Intermediate → Marts modeling with dbt
	•	Incremental model for fct_trip (~3.4M rows handled efficiently)
	•	Source freshness checks & dbt tests (not null, unique, constraints)
	•	Exposures defined for a dashboard dependency graph
	•	DAG lineage visualized via dbt Docs

Folder: dbt-project/nyc_taxi_analytics

2. Databricks Lakehouse Project (coming soon)

Tech: Databricks, Delta Lake, PySpark

	•	Focus on ingesting raw JSON/Parquet data into a bronze-silver-gold pipeline.
	•	Demonstrates Delta Lake merges, deletes, and time travel.
	•	Will include feature engineering with PySpark.

Folder: databricks-lakehouse (planned)

⸻

3. Azure Data Engineering Project (coming soon)

Tech: Azure Data Factory, Synapse, Fabric, Event Hubs

	•	Event-driven ETL pipelines with ADF + Synapse.
	•	Real-time ingestion with Event Hubs → CosmosDB → Synapse Link.
	•	Cost optimization & monitoring with Application Insights.

Folder: azure-etl (planned)

⸻

4. AWS Data Engineering Project (coming soon)

Tech: AWS Glue, Redshift, S3, Lambda, Kinesis

	•	Serverless ETL with Glue + Lambda.
	•	Real-time streaming ingestion with Kinesis → S3 → Redshift.
	•	Data Lakehouse architecture on S3 with partitioning & lifecycle policies.

Folder: aws-etl (planned)

⸻

5. Snowflake Data Warehouse Project (coming soon)

Tech: Snowflake, dbt, Airflow

	•	Building a cloud-native data warehouse with Snowflake.
	•	Orchestration and scheduling via Airflow.
	•	Showcases Snowflake features: zero-copy cloning, streams & tasks, and time travel.

Folder: snowflake-dwh (planned)

⸻

Roadmap

	•	dbt NYC Taxi Analytics project
	•	Databricks Lakehouse project
	•	Azure Data Engineering pipelines
	•	AWS Data Engineering pipelines
	•	Snowflake Data Warehouse
	•	Airflow orchestration example
	•	Real-time streaming (Kafka, Kinesis, Event Hubs)

⸻ 

Setup Instructions (for dbt project)

Requirements

	•	Python 3.11+
	•	dbt-core & dbt-postgres
	•	PostgreSQL running locally (or Docker)

Run Locally

# Clone repo

git clone https://github.com/williamnsambu/modern-data-stack-lab.git

cd modern-data-stack-lab/dbt-project/nyc_taxi_analytics

# Create virtual env
python3.11 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt   # or install dbt manually

# Run dbt models
export DBT_PROFILES_DIR=$(pwd)
dbt debug
dbt run
dbt test

# Generate docs
dbt docs generate
dbt docs serve

⸻

Contributing

This is a personal lab/portfolio, but feel free to open issues or PRs with suggestions.

⸻

Author

William Nsambu
Software & Data Engineer | Cloud Solutions | Modern Data Stack Enthusiast

LinkedIn: www.linkedin.com/in/william-nsambu-a5467ab2 | GitHub: https://github.com/williamnsambu
