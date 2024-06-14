x <- data24
x[,8] <- as.character(x[,8])
sizeTest <- dim(data24)

testthat::test_that("data type", {
  testthat::expect_error(impute_data(x, useParallel = FALSE), "combine")
})

testthat::test_that("missing data",{
  testthat::expect_equal(sum(is.na(data24_imputed)), 0)
})

testthat::test_that("correct dimentions",{
  testthat::expect_identical(dim(data24_imputed), sizeTest)
})

testthat::test_that("no error documentation",{
  expect_silent(help("impute_data"))
})

