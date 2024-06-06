x<-data24
x[,8]<-as.character(x[,8])
sizeTest<-dim(data24)
testnas<-impute_data(data24,useParallel = TRUE)
test_that("data type", {
  expect_error(impute_data(x,useParallel = TRUE),"numeric")
  expect_identical(dim(testnas),sizeTest)
  expect_false(is.na(testnas))
  })
