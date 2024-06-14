x <- data24
l<-data24
l[1,][6] <- NA
x[,8] <- as.character(x[,8])

sizeTest <- dim(data24)

test2<-find_racial_complex(data24)

testthat::test_that("test incorrect data type", {
  testthat::expect_error(find_racial_complex(x[2,]))
})

testthat::test_that("test to enter obervations with missing data",{
  testthat::expect_error(find_racial_complex(l[1,]))
})

testthat::test_that("the function executes in less than five seconds",{
  start_time<-Sys.time()
  result<-find_racial_complex(data24)
  end_time<-Sys.time()
  execution_time<-as.numeric(difftime(end_time,start_time,units = "secs"))
  expect_lt(execution_time,5)
 })

testthat::test_that("correct documentation",{
  expect_silent(help("find_racial_complex"))
})
