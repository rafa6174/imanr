x <- data24
x[1,][6] <- NA

testthat::test_that("test to enter observations with missing data",{
  testthat::expect_no_error(find_racial_complex(x[1,]))
})

x[,8] <- as.character(x[,8])

testthat::test_that("test incorrect data type", {
  testthat::expect_error(find_racial_complex(x[2,]))
})

testthat::test_that("the function executes in less than five seconds",{
  execution_time <- as.numeric(system.time(find_racial_complex(data24)))
  expect_lt(execution_time[3], 5)
 })

testthat::test_that("correct documentation",{
  expect_silent(help("find_racial_complex"))
})

