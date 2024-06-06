test_that("model is random forest",{
  expect_identical(Model_RF_8083$coefnames, names(data31))
})

test_that("data type", {
  expect_identical
})
