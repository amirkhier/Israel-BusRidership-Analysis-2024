# Israel Bus Ridership Analysis 2024

## Project Overview

This repository contains a detailed analysis of Israel's bus ridership data for 2024, including data preparation, analysis, and visualization components.

## Repository Structure

The project is organized into several folders, each serving a specific function:

```plaintext
.
├── AWS_scripts/        # Scripts for ETL in AWS RDS Database server
│   ├──ETL_CreatingTablesSchema.sql #Creating The required Tables in AWS RDS MariaDB server
│   ├──AWS_ETL_LoadingTables.py # Loading the rows in AWS RDS MariaDB database from storaged processed data in AWS s3 
├── data/               # Processed data files after integration and preprocessing
│   ├── PublicTransitRoutesData.csv # use Tableau  ,ipynb
│   ├── PublicTransitRoutesData2.csv # use this especially for ETL instead of using PublicTransitRoutesData.csv
│   ├── GeoLocation.csv #use for ETL , Tableau  ,ipynb
│   └── BusPassengerTimeSlots.csv #use for ETL , Tableau  ,ipynb
├── scripts/            # Scripts for ETL in Local Database
│   ├── ETL_BusProject.sql
├── dashboard/          # Tableau dashboard files
│   └── DashboardBus1.twb
└── BusData.csv # Origin dataset from data.gov.il 
└── Bus_Israel_Notebook.ipynb # EDA Analysis Python Notebook
└── README.md           # Project documentation and usage instructions
└── requirements.txt 
```

### Data Sources and Preprocessing

The datasets in the `data/` folder are processed and integrated versions of the original raw datasets. Here are the original sources and preprocessing details:

1. **Original Data Sources**:
   - **PublicTransitRoutesData** , **PublicTransitRoutesData2** and **BusPassengerTimeSlots**: These datasets were sourced from [Data.gov.il Ridership Dataset](https://data.gov.il/dataset/ridership/resource/e6cfac2f-979a-44fd-b439-ecb116ec0b16), which provides raw data on public transportation routes and ridership statistics.
   - **GeoLocation**: This geographic dataset is a combination of data from:
     - [Geolocations IL GitHub Repository by Yuvadm](https://github.com/yuvadm/geolocations-il/tree/master), which includes city names, latitude, and longitude coordinates.
     - Additional geolocation details from [Data.gov.il](https://data.gov.il), enhancing mapping and spatial analysis.

2. **Data Processing and Integration**:
   - The raw data was preprocessed using Python to clean, transform, and merge datasets.
   - These processed versions (PublicTransitRoutesData.csv, GeoLocation.csv, and BusPassengerTimeSlots.csv) are stored in the `data/` folder and optimized for analysis and visualization.
   - During preprocessing, geolocation data from Yuvadm’s GitHub repository and Data.gov.il was integrated with ridership data, enabling robust spatial analysis and mapping capabilities.

### Schema  Database: 
![image](https://github.com/user-attachments/assets/9d946688-7eb0-4b7a-8628-4983f3c1c32b)


## Setup and Installation

To set up and run this project locally, follow the steps below.

### Prerequisites

- **Python 3.8+**
- **MariaDB** (or a compatible SQL database)
- **Tableau** (for interacting with the dashboard)

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

   - Set up a MariaDB database and load the data using the `ETL_BusProject.sql` script in the `scripts/` folder.
   - Open the MariaDB command line or a database management tool and run:

     ```sql
     SOURCE /path/to/scripts/ETL_BusProject.sql;
     ```

   - **Note**: Ensure that your database credentials are set up in an environment file (`.env`) or directly in the scripts if needed.


5. **Open and Explore the Tableau Dashboard**

   - Open the `DashboardBus1.twb` file in Tableau.
   - Connect to the data if prompted, and explore the interactive visualizations of the bus ridership analysis.

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


## Architecture Of Work:
![image](https://github.com/user-attachments/assets/de3b600f-ebae-41d4-bf25-53cfdca1a2e5)


