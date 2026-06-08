# AWS Data Engineering Youtube Stats Project

This is a AWS cloud-based data engineering project that ingests, transforms, and analyzes on the structured and semi-structured YouTube videos data based on the video categories and the trending metrics using a fully managed AWS stack through to an interactive BI QuickSight dashboard.

## Dataset

This [Kaggle dataset](https://www.kaggle.com/datasets/datasnaek/youtube-new) contains statistics (CSV and Json files) on daily popular YouTube videos over the course of many months. There are up to 200 trending videos published every day for many locations. The data for each region is in its own file. The video title, channel title, publication time, tags, views, likes and dislikes, description, and comment count are among the items included in the data.

## AWS Services Used in project

- Amazon S3 - acts as the data lake backbone. Raw, cleansed, and analytics-ready data each live in separate S3 prefixes to keep the layers clean.
- AWS Lambda - handles the first transformation step: whenever a new JSON file lands in the raw bucket, Lambda fires, parses the category mappings, and writes a normalized Parquet file to the cleansed zone.
- AWS Glue - runs the heavier PySpark ETL job that joins the cleansed CSV stats with the normalized category data and writes the final analytics table in columnar format.
- AWS Athena - queries the analytics layer directly from S3 using standard SQL. No cluster to spin up, no data to move.
- Amazon QuickSight - connects to Athena to build dashboards on top of the processed data, answering questions about what types of content trend by region, engagement patterns, and more.
- AWS IAM - manages least-privilege roles for each service so nothing has more access than it needs.

## Architecture

<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/352ac8d8-f099-4ad9-80cf-15f1f3b4592e" />

- Parquet over CSV at every layer after ingestion — significantly faster Athena queries and lower scan costs.
- Event-driven Lambda trigger on S3 PUT means new data gets processed automatically without any orchestration overhead.
- Glue crawler + Data Catalog keeps the schema discoverable without hardcoding it anywhere in the ETL.
- Separating raw / cleansed / analytics into distinct S3 prefixes (the medallion-style approach) made debugging much easier - you can always trace a bad record back to its source.

## Steps to Reproduce

1. Upload the Kaggle dataset to an S3 raw bucket using s3_cli_command.sh
2. Deploy lambda_function.py as a Lambda function and set up an S3 event trigger on the raw JSON prefix
3. Create a Glue job and point it at the cleansed S3 location
4. Run a Glue crawler on the analytics output to register it in the Data Catalog
5. Query via Athena and connect QuickSight for dashboarding



