x <- data24
x[,8] <- as.character(x[,8])
sizeTest <- dim(data24)
testnas <- impute_data(data24, useParallel = FALSE)

testthat::test_that("data type", {
  testthat::expect_error(impute_data(x, useParallel = FALSE), "combine")
})

testthat::test_that("missing data",{
  testthat::expect_equal(sum(is.na(testnas)), 0)
})

testthat::test_that("correct dimentions",{
  testthat::expect_identical(dim(testnas), sizeTest)
})

testthat::test_that("no error documentation",{
  expect_silent(help("impute_data"))
})

