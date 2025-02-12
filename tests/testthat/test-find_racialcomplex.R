x <- data24
x[,8] <- as.character(x[,8])

testthat::test_that("test incorrect data type", {
  testthat::expect_error(find_racial_complex(x[2,]))
})

x <- data24[,-1]
testthat::test_that("test to enter observations with missing data",{
  testthat::expect_error(find_racial_complex(x[1,]))
})

testthat::test_that("correct documentation",{
  expect_silent(help("find_racial_complex"))
})

