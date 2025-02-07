# imanr 2.0.0

## Major Updates
- **Replaced Random Forest model with Boosted Ensemble**  
  - The package now uses a **Boosted Ensemble (XGBoost)** model instead of the previous **Random Forest**.  
  - This transition **increases accuracy while reducing model size**, significantly improving efficiency.  

- **Enhanced computational performance**  
  - Model inference is now **faster and more memory-efficient**.  
  - The package remains fully functional while requiring significantly less storage.  

## Bug Fixes & Improvements
- Optimized data handling and model integration for improved usability.  
- Minor updates to documentation and internal functions.  

# imanr 1.0.2

* After receiving feedback from previous CRAN submission, some adjustments were made.
  * bdMaiz, the database used as basis for imputation was reduced in size to optimize the function working time.
  * The examples and tests were adjusted so that installation time is shorter.

# imanr 1.0.1

* After receiving feedback from previous CRAN submission, some adjustments were made.
  * Parallelization is done with `doParallel` for improved performance and compatibility. 
  * License file is added. 
  * Documentation fixes in the Author, Title and Import fields.
  * Some links that were previously broken were fixed for the README file.

# imanr 1.0.0

* Version was upgraded for sending the package to CRAN evaluation.

## imanr 0.1.0.9000

* This is a development version. 
* Added a `NEWS.md` file to track changes to the package.
