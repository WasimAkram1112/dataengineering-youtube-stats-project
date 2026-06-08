import awswrangler as wr
import pandas as pd
import urllib.parse
import os
import boto3
import json

os_input_s3_cleansed_layer = os.environ['s3_cleansed_layer']
os_input_glue_catalog_db_name = os.environ['glue_catalog_db_name']
os_input_glue_catalog_table_name = os.environ['glue_catalog_table_name']
os_input_write_data_operation = os.environ['write_data_operation']


def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    s3 = boto3.client('s3')

    try:
        # Read file from S3
        obj = s3.get_object(Bucket=bucket, Key=key)
        raw_json = obj['Body'].read().decode('utf-8')
        data = json.loads(raw_json)

        # Flatten the "items" array
        df_step_1 = pd.json_normalize(data['items'])

        print("DataFrame shape:", df_step_1.shape)

        # Write to S3 as Parquet
        wr_response = wr.s3.to_parquet(
            df=df_step_1,
            path=os_input_s3_cleansed_layer,
            dataset=True,
            database=os_input_glue_catalog_db_name,
            table=os_input_glue_catalog_table_name,
            mode=os_input_write_data_operation
        )

        print("Write successful:", wr_response)
        return wr_response

    except Exception as e:
        print("Error:", e)
        raise e
