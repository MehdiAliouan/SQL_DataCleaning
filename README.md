## SQL_DataCleaning

I used SQLQuery to do some Data Cleaning of Dataset from Kaggle : [Nashvile_Housing_Data](https://www.kaggle.com/datasets/tmthyjames/nashville-housing-data)


Situation: 

The project aims to clean and standardize a dataset of Nashville housing data contained in the dbo.Housing_Data table. The dataset includes information such as property addresses, owner addresses, sale dates, and whether properties were sold as vacant.

Task: 

The task was to clean the data by standardizing date formats, populating missing addresses, breaking out composite address fields into individual columns, converting boolean-like fields to more readable formats, and removing duplicates to ensure data quality and consistency.

Action:

Standardized date formats by adding a new column SaleDateConverted and converting existing date values.
Populated missing PropertyAddress data by joining the table on ParcelID and copying addresses from matching rows.
Split PropertyAddress and OwnerAddress into individual columns for address, city, and state.
Converted 'Y' and 'N' values in the SoldAsVacant column to 'Yes' and 'No'.
Removed duplicate rows based on key fields using a common table expression (CTE).
Dropped unused columns to streamline the dataset.

Result:

The dataset was successfully cleaned and standardized, making it more consistent and easier to analyze. The transformations ensured that all relevant fields were populated, dates were in a standard format, addresses were broken out into individual components, and duplicate entries were removed.
