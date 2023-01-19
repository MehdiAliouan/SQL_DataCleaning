--Cleaning Data of Nashville Housing  With SQL Queries

Select *
From dbo.Housing_Data

--Standardizing Date Format

Alter Table dbo.Housing_Data
Add SaleDateConverted Date;

Update dbo.Housing_Data
Set SaleDateConverted = CONVERT(Date,SaleDate)

--Select SaleDate,SaleDateConverted
--From dbo.Housing_Data


--Populate PropertyAddress Data

Select *
From dbo.Housing_Data
Where PropertyAddress is null
Order By ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, 
ISNULL(a.PropertyAddress,b.PropertyAddress)
From dbo.Housing_Data a
JOIN dbo.Housing_Data b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From dbo.Housing_Data a
JOIN dbo.Housing_Data b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

--Select PropertyAddress, ParcelID
--From dbo.Housing_Data
--Where PropertyAddress is null
--Order By ParcelID;

--Breaking out Adress into Individual Columns (Address, City, State)

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From dbo.Housing_Data


ALTER TABLE dbo.Housing_Data
Add PropertySplitAddress Nvarchar(255);

Update dbo.Housing_Data
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE dbo.Housing_Data
Add PropertySplitCity Nvarchar(255);

Update dbo.Housing_Data
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




Select *
From dbo.Housing_Data





Select OwnerAddress
From dbo.Housing_Data
--Where OwnerAddress is not null


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From dbo.Housing_Data



ALTER TABLE Housing_Data
Add OwnerSplitAddress Nvarchar(255);

Update Housing_Data
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Housing_Data
Add OwnerSplitCity Nvarchar(255);

Update Housing_Data
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE Housing_Data
Add OwnerSplitState Nvarchar(255);

Update Housing_Data
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From Housing_Data
Where OwnerAddress is not null;

--Change Y and N to Yes and No in "Sold as Vacant" Column

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From Housing_Data
Group By SoldAsVacant
Order By 2;

Update Housing_Data
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
When SoldAsVacant = 'N' THEN 'NO'
ELSE SoldAsVacant
END;

--Select SoldAsVacant, COUNT(SoldAsVacant)
--From Housing_Data
--Group By SoldAsVacant;


--Remove Duplicates

WITH CTE AS (
SELECT *, ROW_NUMBER() OVER(PARTITION BY PropertyAddress, ParcelID, SalePrice, SaleDate, LegalReference 
ORDER BY UniqueID) as rn
FROM housing_data
)
DELETE FROM CTE WHERE rn > 1;

--Select*
--From Housing_Data;

--Delete Unused Columns

ALTER TABLE Housing_Data
DROP COLUMN PropertyAddress,SaleDate, OwnerAddress,TaxDistrict,SalesDateConverted;



