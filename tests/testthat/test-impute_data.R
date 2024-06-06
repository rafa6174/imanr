data<-as.dataframe(data)
tipdat<-c()
for(i in 1:length(data24)){
  tipdat<-c(tipdat,is.numeric(data[,i]))
}
test_that("data type", {
  expect_identical(tipdat,rep(TRUE,length(data24)))
})
