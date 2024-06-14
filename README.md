
<!-- badges: start -->

[![License](https://img.shields.io/badge/License-GPL3-blue.svg)](https://github.com/rafa6174/imanr/blob/main/LICENSE.md)
[![GitHub R package
version](https://img.shields.io/github/r-package/v/rafa6174/imanr/master)](https://github.com/rafa6174/imanr)
[![R-CMD-check](https://github.com/rafa6174/imanr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rafa6174/imanr/actions/workflows/R-CMD-check.yaml)
<!-- [![CRAN/METACRAN](https://img.shields.io/cran/v/ecocbo)](https://cran.r-project.org/package=ecocbo) -->
<!--  [![GitHub R package version](https://img.shields.io/badge/R-v1.0.0-orange)](https://github.com/rafa6174/imanr) -->
<!-- ![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/imanr?color=yellow) -->
<!-- badges: end -->

# imanr <a href="https://github.com/rafa6174/imanr"><img src="vignettes/images/hex-imanr.png" align="right" height="138" /></a>

## Identify the Racial Complex of Native Corns from Mexico

### Identificador de Maíz Nativo en R

**imanr** is model that provides researchers with a powerful tool for
the classification and study of native corn by aiding in the
identification of racial complexes which are fundamental to Mexico’s
agriculture and culture.

### Installation

``` r
# As of today, you can install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("rafa6174/imanr")
```

### Usage

The package is composed of two functions: `find_racial_complex()` and
`impute_data()`.

`impute_data()` is used to preprocess the data by imputing the missing
information by comparing the absent fields with the full information
from the “Proyecto Nacional de Maíz Nativo” database and then filling
the gaps with adequate data that is computed through a random forests
approach. `find_racial_complex()` is loaded with the machine learning
model that computes the classification for the corn sample that is being
fed to the function. The function takes only one argument which is a
dataframe including qualitative and quantitative characteristics of the
native corn.

``` r
# test for racial complexes
find_racial_complex(data31)

#> [1] Tropicales tardíos  Dentados tropicales Dentados tropicales Dentados tropicales
#> [5] Dentados tropicales Dentados tropicales Dentados tropicales Dentados tropicales
#> [9] Dentados tropicales Dentados tropicales Dentados tropicales Dentados tropicales
#> [13] Dentados tropicales Dentados tropicales Dentados tropicales Dentados tropicales
#> [17] Dentados tropicales Dentados tropicales Tropicales tardíos  Dentados tropicales
#> [21] Dentados tropicales Dentados tropicales Dentados tropicales Dentados tropicales
#> [25] Dentados tropicales Dentados tropicales Dentados tropicales Dentados tropicales
#> [29] Dentados tropicales Dentados tropicales Dentados tropicales
#> 7 Levels: Chapalote Cónico Dentados tropicales Ocho hileras ... Tropicales tardíos
```

### R packages required for running imanr

- Required: missForest, caret, ranger, dplyr, parallel, doParallel,
  foreach

### Participating institutions

![](man/figures/logoCONACYT.png)

<img src="man/figures/logoUAEH.png" height="121" />
<img src="man/figures/logoENES.png" height="121" />
