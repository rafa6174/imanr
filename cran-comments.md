## Update to imanr 2.0.0

── R CMD check results ───────────────────────────────────────────────── imanr 2.0.0 ────
Duration: 12m 24.6s

❯ checking installed package size ... NOTE
    installed size is  5.3Mb
    sub-directories of 1Mb or more:
      R   4.7Mb

This is a major update that optimizes the package by replacing an excessively large Random Forest model (~58MB) with a much lighter and more efficient Boosted Ensemble model (~5MB).

Due to the nature of the model included in the 'sysdata.rda' file, which is essential for the primary functionality of the package, we were unable to reduce the size below 5 MB despite extensive efforts to compress and optimize the data. The new model, a Boosted Ensemble trained using the `xgboost` package, replaces the previous Random Forest model. This transition significantly improves computational efficiency and predictive accuracy.

Including the model within the package is crucial to ensuring a seamless user experience. Externalizing it would require additional steps for data acquisition, potentially degrading usability and limiting accessibility, particularly for offline users.

Therefore, we kindly request an exemption from the 5MB size limit due to these technical constraints and the importance of preserving the package’s functionality and user convenience.

Thank you for your time and consideration.

## Resubmission 3

── R CMD check results ────────────────────────────────────────────────────── imanr 1.0.2 ────
Duration: 4m 33.7s

❯ checking installed package size ... NOTE
    installed size is  5.8Mb
    sub-directories of 1Mb or more:
      R   5.6Mb

0 errors ✔ | 0 warnings ✔ | 1 note ✖

Thanks for reviewing our package submission. In consideration for the received comments we have:

- Pls reduce to less than 5 MB.
  - Due to the nature of the model included in the 'sysdata.rda' file, which is essential for the primary functionality of the package, we were unable to reduce the size below 5 MB despite extensive efforts to compress and optimize the data. The model, a RandomForest implemented using the `ranger` package, originally exceeds 50 MB but has been reduced to 5.5 MB within the 'sysdata.rda' file. This model is crucial for the accurate and efficient performance of the package. Externalizing it would significantly degrade the user experience by requiring additional steps for data acquisition. Therefore, we kindly request an exemption from the size limit due to these technical constraints and the importance of maintaining the package's functionality and user convenience.
- Non-standard file/directory found at top level: 'cran-comments.html'
  - As suggested, the file 'cran-comments.html' has been included in the '.Rbuildignore' file to ensure it does not interfere with the package building process.
- Overall checktime 19 min > 10 min. Please reduce to max 10 min.
  - The check time has been reduced by optimizing the `impute_data` function, resulting in faster execution. Additionally, some tests have been streamlined to comply with the check time requirement.



## Resubmission 2

Thank you for reviewing our package submission. We have carefully considered the note regarding possibly misspelled words in the DESCRIPTION file. We would like to clarify the following:

- **Maíces, México, Nativos, Proyecto**, de: These words are part of the official project title "Proyecto Global de Maíces Nativos de México". This project is a well-recognized initiative in the study and preservation of native maize in Mexico. Therefore, these terms are not misspellings but are used correctly within this specific context.
- **ces, xico**: These are likely fragments of "Maíces" and "México", respectively, which are part of the same project title. The full terms "Maíces" and "México" are correctly spelled and used in context.

## Resubmission 1

── R CMD check results ────────────────────────────────── imanr 1.0.1 ────
Duration: 19m 22.6s

❯ checking installed package size ... NOTE
    installed size is  6.2Mb
    sub-directories of 1Mb or more:
      R   5.6Mb

0 errors ✔ | 0 warnings ✔ | 1 note ✖

This is a resubmission. The following updates have been made:

- Possibly misspelled words in DESCRIPTION: 
  - **Nativos, Proyecto, ces, de, xico, Maíces, México:** These words are not misspelled as they are part of the official title "Proyecto Global de Maíces Nativos de México" from where the data to train the model comes from.
  - **morphometric:** The term [Morphometrics](https://www.merriam-webster.com/medical/morphometrics) refers to the quantitative analysis of form, which is a concept that encompasses both the size and shape of an organism or organ.  However, for clarity, it has been changed to 'physical' in the DESCRIPTION.
- Author field should be Authors@R.
  - This field has been updated to use the correct format.
- Found the following (possibly) invalid URLs: ...
  - The URL is updated and validated. [License](https://github.com/rafa6174/imanr/blob/main/LICENSE.md) 
- Found the following (possibly) invalid URIs: ...
  - Email addresses have been formatted correctly using `mailto:` links.
- The Title field should be in title case.
  - The title has been corrected to use title case.
- Uses the superseded package: 'doSNOW'
  - The code has been updated to use 'doParallel' instead of 'doSNOW' for better performance and compatibility.

── R CMD check results ───────────────────────────────────────── imanr 1.0.0 ────
Duration: 11m 26.4s

❯ checking installed package size ... NOTE
    installed size is  6.2Mb
    sub-directories of 1Mb or more:
      R   5.6Mb

0 errors ✔ | 0 warnings ✔ | 1 note ✖

* This is a new release.

* We have added the \donttest{} directive to the example included with the impute_data() function because its execution requires more than 5 seconds, as it is quite intensive in terms of computation time. Although the example is primarily instructional for the end user, it has been set up to demonstrate the correct use of the function. While the code will not be executed automatically during the review process, it remains available for manual execution if desired.

* The installed size of the package is 6.2 MB, with the R sub-directory being 5.6 MB. This size is primarily due to the inclusion of a random forest model which is essential for the functionality of the package and the `find_racial_complex()` function. We have attempted to compress the model to reduce the installation size, but these efforts did not yield significant results. The model's inclusion is crucial as it directly supports the primary functionality of the package. Therefore, despite our best efforts to optimize the package size, the current size is justified by the indispensable nature of the included model. 

* The package was checked with GitHubActions to make sure that it works on different platforms and it passed test in all of them (i.e. macos-latest(release), windows-latest(release), ubuntu-latest(devel), ubuntu-latest(release), ubuntu-latets(oldrel-1)).

