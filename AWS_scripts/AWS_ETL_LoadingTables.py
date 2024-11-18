import pandas as pd
import boto3
from sqlalchemy import create_engine, inspect
from io import StringIO

# AWS S3 Configuration
s3_bucket_name = "YourBucket"
s3_file_keys = ["PublicTransitRoutesData2.csv", "GeoLocation.csv", "BusPassengerTimeSlots.csv"]
# Database connection details
username = "yourusername"
password = "yourpassword"
host = "yourhost"
port = "3306"
database = "Bus_Database"

# Create the connection string and engine
engine = create_engine(f"mariadb+mariadbconnector://{username}:{password}@{host}:{port}/{database}")

# Set up S3 client
s3 = boto3.client("s3")

# Define the table names and chunk sizes
table_names = ["PublicTransitRoutesData", "GeoLocation", "BusPassengerTimeSlots"]
chunk_sizes = [15000, 15000, 15000]


def fetch_sql_columns(table_name):
    """Fetch column names from the SQL table."""
    inspector = inspect(engine)
    columns = inspector.get_columns(table_name)
    sql_columns = [col["name"] for col in columns]
    return sql_columns


# Download the CSV from S3 and load it in chunks
try:
    for i in range(len(s3_file_keys)):
        # Fetch SQL table column names
        sql_columns = fetch_sql_columns(table_names[i])
        print(f"SQL columns for {table_names[i]}: {sql_columns}")

        # Load file from S3 into memory
        print(f"Fetching file: {s3_file_keys[i]} from bucket: {s3_bucket_name}")
        csv_obj = s3.get_object(Bucket=s3_bucket_name, Key=s3_file_keys[i])
        csv_data = csv_obj["Body"].read().decode("utf-8")

        # Use StringIO to load the CSV data as if it were a file
        csv_file = StringIO(csv_data)

        # Read the CSV headers and auto-map them to SQL columns
        for chunk in pd.read_csv(csv_file,encoding='utf-8-sig', chunksize=chunk_sizes[i]):
            # Automatically map CSV columns to SQL table columns
            csv_columns = chunk.columns.tolist()
            column_mapping = {csv_col: sql_col for csv_col, sql_col in zip(csv_columns, sql_columns)}

            # Rename the columns in the DataFrame
            chunk.rename(columns=column_mapping, inplace=True)

            # Insert the chunk into the SQL table
            chunk.to_sql(name=table_names[i], con=engine, if_exists="append", index=False)
            print(f"Inserted chunk of {len(chunk)} rows into table {table_names[i]}")

        print(f"Data loading complete for file: {s3_file_keys[i]}.")

except Exception as e:
    print(f"An error occurred: {e}")