## resubmission
This is a resubmission. In this version we have:

- Possibly misspelled words in DESCRIPTION: 
  - (Nativos, Proyecto, ces, de, xico, Maíces, México) The original data with which the model was trained comes from a project titled "Proyecto Global de Maíces Nativos de México", thus these words are not misspelled in the DESCRIPTION.
  - (morphometric) Morphometrics refers to the quantitative analysis of form, which is a concept that encompasses both the size and shape of an organism or organ. https://www.sciencedirect.com/topics/medicine-and-dentistry/morphometrics https://www.merriam-webster.com/medical/morphometrics
- Author field should be Authors@R.  Current value is:
  - The field was fixed.
- Found the following (possibly) invalid URLs:
  - The URL is updated and validated. https://github.com/rafa6174/imanr/blob/main/LICENSE.md
- Found the following (possibly) invalid URIs:
  - The email addresses were adjusted.  
- The Title field should be in title case.
  - The title was corrected
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

