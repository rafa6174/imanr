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

testthat::test_that("the function executes in less than five muntes",{
  star_time<-Sys.time()
  result<-impute_data(data24)
  end_time<-Sys.time()
  execution_time<-as.numeric(difftime(end_time,star_time,units = "mins"))
  expect_lt(execution_time,5)
})
