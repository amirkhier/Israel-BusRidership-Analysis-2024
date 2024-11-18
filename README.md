# Israel Bus Ridership Analysis 2024

## Project Overview

This repository contains a detailed analysis of Israel's bus ridership data for 2024, including data preparation, analysis, and visualization components.

## Repository Structure

The project is organized into several folders, each serving a specific function:

```plaintext
.
├── AWS_scripts/        # Scripts for ETL in AWS RDS Database server
│   ├── ETL_CreatingTablesSchema.sql  # Creating The required Tables in AWS RDS MariaDB server
│   ├── AWS_ETL_LoadingTables.py     # Loading the rows in AWS RDS MariaDB database from stored processed data in AWS S3
|   ├── requirements.txt     # requirements for AWS_ETL_LoadingTables.py  
├── data/               # Processed data files after integration and preprocessing
│   ├── PublicTransitRoutesData.csv  # Use Tableau, ipynb
│   ├── PublicTransitRoutesData2.csv # Use for ETL instead of using PublicTransitRoutesData.csv
│   ├── GeoLocation.csv  # Use for ETL, Tableau, ipynb
│   └── BusPassengerTimeSlots.csv  # Use for ETL, Tableau, ipynb
├── scripts/            # Scripts for ETL in Local Database
│   ├── ETL_BusProject.sql
├── dashboard/          # Tableau dashboard files
│   └── DashboardBus1.twb
└── BusData.csv         # Origin dataset from data.gov.il 
└── Bus_Israel_Notebook.ipynb  # EDA Analysis Python Notebook
└── README.md           # Project documentation and usage instructions
└── requirements.txt 
```

## Data Sources and Preprocessing

The datasets in the `data/` folder are processed and integrated versions of the original raw datasets. Here are the original sources and preprocessing details:

1. **Original Data Sources**:
   - **PublicTransitRoutesData**, **PublicTransitRoutesData2**, and **BusPassengerTimeSlots**: These datasets were sourced from [Data.gov.il Ridership Dataset](https://data.gov.il/dataset/ridership/resource/e6cfac2f-979a-44fd-b439-ecb116ec0b16), which provides raw data on public transportation routes and ridership statistics.
   - **GeoLocation**: This geographic dataset is a combination of data from:
     - [Geolocations IL GitHub Repository by Yuvadm](https://github.com/yuvadm/geolocations-il/tree/master), which includes city names, latitude, and longitude coordinates.
     - Additional geolocation details from [Data.gov.il](https://data.gov.il), enhancing mapping and spatial analysis.

2. **Data Processing and Integration**:
   - The raw data was preprocessed using Python to clean, transform, and merge datasets.
   - These processed versions (PublicTransitRoutesData.csv, GeoLocation.csv, and BusPassengerTimeSlots.csv) are stored in the `data/` folder and optimized for analysis and visualization.
   - During preprocessing, geolocation data from Yuvadm’s GitHub repository and Data.gov.il was integrated with ridership data, enabling robust spatial analysis and mapping capabilities.

### Schema Database

![image](https://github.com/user-attachments/assets/9d946688-7eb0-4b7a-8628-4983f3c1c32b)

## Setup and Installation

To set up and run this project locally, follow the steps below.

### Prerequisites

- **Python 3.8+**
- **MariaDB** (or a compatible SQL database)
- **Tableau** (for interacting with the dashboard)
- **AWS CLI** (for optional AWS RDS integration)

### Installation Steps

1. **Clone the Repository**

   Clone this repository to your local machine:

   ```bash
   git clone https://github.com/username/Israel-BusRidership-Analysis.git
   cd Israel-Bus-Ridership-Analysis
   ```

2. **Create a Virtual Environment (Optional but Recommended)**

   ```bash
   python -m venv env
   source env/bin/activate  # On Windows: env\Scripts\activate
   ```

3. **Install Dependencies**

   Use the `requirements.txt` file to install all necessary Python packages:

   ```bash
   pip install -r requirements.txt
   ```

4. **Database Setup**

   - **Local Database Setup**:
     - Set up a MariaDB database and load the data using the `ETL_BusProject.sql` script in the `scripts/` folder.
     - Open the MariaDB command line or a database management tool and run:

       ```sql
       SOURCE /path/to/scripts/ETL_BusProject.sql;
       ```

   - **AWS RDS Database Setup (Optional)**:
     - If you want to load the data into an AWS RDS MariaDB instance, follow the steps in the `AWS_scripts/` folder:
       1. **Create Tables in AWS RDS**:
          - Run the `ETL_CreatingTablesSchema.sql` script on your AWS MariaDB instance to create the necessary tables.
       2. **Load Data into AWS RDS**:
          - Use the `AWS_ETL_LoadingTables.py` script to load the processed data from AWS S3 to your AWS RDS MariaDB database.

     Make sure your AWS credentials are set up (see [AWS CLI Setup](#aws-cli-setup)).

5. **Open and Explore the Tableau Dashboard**

   - Open the `DashboardBus1.twb` file in Tableau.
   - Connect to the data if prompted, and explore the interactive visualizations of the bus ridership analysis.

---

## Usage

### **Data Exploration with `Bus_Israel_Notebook.ipynb`**

   - **Libraries Used**:
     - `numpy` (imported as `np`): For numerical operations.
     - `pandas` (imported as `pd`): For data manipulation and analysis.
     - `matplotlib.pyplot` (imported as `plt`): For data visualization.
     - `seaborn` (imported as `sns`): For enhanced data visualization.
     - `sys`: For accessing system-specific parameters and functions.
     - `warnings`: To handle warning messages (filtered in this notebook).
     - `bidi.algorithm` (specifically `get_display`): For handling bidirectional text display, useful for right-to-left languages.
     - `pingouin` (imported as `pg`): For statistical analysis.
     - `plotly.express` (imported as `px`): For interactive visualizations.
     - `thefuzz.process`: For fuzzy string matching.

   - **Description**: 
     - Open the `Bus_Israel_Notebook.ipynb` in the `notebooks/` folder to explore data trends, analyze bus ridership patterns, and visualize key insights.
     - The notebook covers various aspects of the data, including time-based, location-based, and agency-based analyses.

   - **Usage**:
     - Run the notebook in a Jupyter environment, such as Jupyter Notebook or JupyterLab, or open it in a compatible platform like Google Colab.
     - Step through each code cell to reproduce the analysis and visualizations.

---

### **ETL Process in AWS with `AWS_ETL_LoadingTables.py`**

   - The `AWS_ETL_LoadingTables.py` script loads data from processed files stored in AWS S3 into an AWS RDS MariaDB instance.
   
   - **Libraries Used**:
     - `boto3`: AWS SDK for Python, used for interacting with AWS services, including S3.
     - `sqlalchemy.create_engine`: Used for creating a connection to the AWS RDS MariaDB instance.
     - `sqlalchemy.inspect`: Used for inspecting the structure of the database and tables before data insertion.

   Example snippet from `AWS_ETL_LoadingTables.py`:

   ```python
   import boto3
   from sqlalchemy import create_engine, inspect

   # Initialize S3 client and RDS engine
   s3_client = boto3.client('s3')
   rds_engine = create_engine('mariadb+pymysql://username:password@host:port/database')

   # Check if the database table exists
   inspector = inspect(rds_engine)
   if 'bus_data' not in inspector.get_table_names():
       print("Table doesn't exist!")
       # Create table schema if needed (you can automate this with SQLAlchemy or raw SQL)

   # Load data from S3 into RDS (example code for loading from CSV)
   bucket_name = 'your-bucket-name'
   file_key = 'your-data-file.csv'
   s3_object = s3_client.get_object(Bucket=bucket_name, Key=file_key)
   data = pd.read_csv(s3_object['Body'])

   data.to_sql('bus_data', con=rds_engine, if_exists='replace', index=False)
   ```

   This script will automatically load the data from S3 into your AWS RDS instance, allowing you to continue with your analysis in the cloud.

---

## AWS CLI Setup (Optional for AWS Integration)

If you plan to load data into AWS RDS or interact with other AWS services like S3, you’ll need to configure the AWS CLI.

### 1. **Download and Install the AWS CLI**

- **Windows**: Download and run the installer from [AWS CLI Windows installer](https://aws.amazon.com/cli/).
- **macOS**: Install with Homebrew:
  
  ```bash
  brew install awscli
  ```
  
- **Linux**: Install using your package manager or follow the [AWS

 CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html).

### 2. **Configure AWS CLI Credentials**

1. Run the following command to configure your AWS credentials:

   ```bash
   aws configure
   ```

2. Enter the following details when prompted:
   - **AWS Access Key ID**
   - **AWS Secret Access Key**
   - **Default region name** (e.g., `us-east-1`)
   - **Default output format** (choose `json`)

3. Verify your configuration by running:

   ```bash
   aws sts get-caller-identity
   ```

### 3. **Use AWS Credentials in Your Repository**

Once configured, the AWS CLI automatically uses the stored credentials in the `~/.aws/credentials` file. You can interact with AWS services (e.g., S3, RDS) in your Python scripts using `boto3`.

Example of using `boto3` in your repository:

```python
import boto3

# Create an S3 client
s3 = boto3.client('s3')

# List S3 buckets
response = s3.list_buckets()
for bucket in response['Buckets']:
    print(bucket["Name"])
```

---
## Architecture Of Work in local database

![_דיאגרמה ללא שם_-_עמוד-1_](https://github.com/user-attachments/assets/e0acbdfc-b3aa-4f3b-b71c-3e4ee5c9985d)

## Architecture Of Work(Optional)

![image](https://github.com/user-attachments/assets/de3b600f-ebae-41d4-bf25-53cfdca1a2e5)
