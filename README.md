# An investigation of data from patients in the prone position

This project outlines the processing and investigation of data generated from critically ill patients who undergo invasive prone-position ventilation in an Intensive Care Unit (ICU).

## Project overview

The initial phase involves generating output from a tool that can be set to query the recorded data relating to a patient who has been cared for in the ICU of the hospital in question. The electronic record system used in the ICU of interest is Metavision by iMDSoft.

### Data wrangling

Data stored within Metavision can be queried using the Metavision Query Wizard, a front-end tool. The queries have some limitations, but the majority of recorded data is accessible. The output generated is in an 'untidy' format (Wickham 2015). The first step of analysis must therefore involve a sequence of steps that can render the data to a tidy format that can undergo further analysis.

#### Data wrangling sequence

The data must be anonymised, and transformed to a 'tidy' format (Wickham 2014) before analysis can proceed.

The following steps are identified, and scripts written to accommodate the steps.

**1. Load necessary packages** (packages_for_gas_efficiency.R)

-   *this script should be run at the start of each session*
-   including `readxl`, `janitor`, `tidyverse`, `lubridate`, `writexl`
-   the `googledrive` package allows outputs to be uploaded to Google Drive

**2. Choose from raw MV Query output files** (source_files.R)

-   view a list available output files
-   choose file to import

**3. Enter basic details** (demographics.R)

-   one issue is that certain basic details (height, weight...) are entered inconsistently. The solution is to display what the file contains and then have the user enter the relevant values
-   when the .xlsx file is read in, the patients DOB is coerced to a strange format. The best solution here is to manually open the .xlsx file to get the DOB directly

**4. Import and pivot the patient data** (import_data.R)

-   This represents the key step, where the data is pared down and pivoted to a wide format

**5. Coerce data to useful formats** (coerce_datatypes.R)

-   The data remains entirely in character format. This script separates the dataframe into two. The first is of columns that will remain in character form and the other consists of columns that will be coerced to numeric format to enable analysis and calculation in the future.

**6. Calculate some new values** (add_new_gas_indices.R)

-   This script calculates and adds:

    -   PF ratio
    -   Aa gradient
    -   CaO2

-   The only remaining step that needs to be added here is the calculation of mechanical power delivered to the lung (as per Gattinoni 2016)

-   The addition of cardiac outpout values here by the Liljestrand and Zander method (see Koenig 2015 and Sun 2005) could be explored here, but the difficulty in performing further cardiovascular calculations is that we do not know how much vasopressor medication the patient is being infused with (see add_new_CO_indices.R). The accessible Metavision server only stores **if** an infusion is running, but **not the rate**. Therefore, the only way to access this data is to manually enter it by transcribing it from Metavision.

**7. BMI** BMI_processing.R

-   This script calculates the patients BMI after checking if a height and weight has been recorded for the patient. If no height is recorded, the column is created but populated with NAs.

-   Also creates a new column to show if the data necessary to record BMI was present. This is in anticipation of using techniques to impute NAs with other values (it will show if the value is imputed or actual)

**8. Divide the data into groups** create_subtibbles.R

-   This script isolates certain specific groups of variables and places the dfs in a list that can be later used to populate sheets in a .xlsx output

-   Future work will need to incorporate a step where the user specifies which ventilator the patient was using when undergoing invasive ventilation. For the Covid-19 patients this is always the Puritan Bennett model by Medtronic, but if patients before this time period are added, there are seversal other ventilators in use.

**9. Save output .xlsx files** file_outputs.R

-   This script saves the anonymised wrangled data as a .xlsx file to the hard drive, and also uploads a copy to google drive.

This represents my approach to wrangling the data. I have now designed a filter for the Metavision Query Wizard output that captures essentially any data we have available, with the following notable features:

-   infusions are absent. The accessible Metavision server only stores **if** an infusion is running, but **not the rate**. Therefore, the only way to access this data is to manually enter it by transcribing it from Metavision.
-   The data accessible is 'verified'. This is data that the bedside nurse has signed off on as accurate, and is usually a set of vitals once per hour. Cardiovascular data is stored once per minute, but the Query Wizard crashes if a large amount of this is accessed. Richard;'s SQL approach does **not** have this problem.
-   The ABG data is transcribed to Metavision by the nurse at the bedside, so it subject to error. The full data is available from the analyser.

### Data exploration

This section is undergoing development.
