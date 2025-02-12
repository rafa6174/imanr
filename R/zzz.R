.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Checking Boosted Ensemble model...")

  tryCatch({
    # Obtain the model from the downloading function
    download_model()

    # Assign the model to the package namespace
    # assign("BE_model_unbundled", model, envir = asNamespace(pkgname))
    # packageStartupMessage("Model loaded and assigned to package namespace.")
  }, error = function(e) {
    warning("Failed to load model: ", e$message)
  })
}

.onLoad <- function(libname, pkgname) {
  # This is added so that themodel is available when using the package
  # It's not necessary to reload, as it was done with .onAttach

}
