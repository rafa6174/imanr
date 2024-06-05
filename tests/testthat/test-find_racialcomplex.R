test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("model is random forest",{
  expect_identical(Model_RF_8083$coefnames, names(data31))
})
