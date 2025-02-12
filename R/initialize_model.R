#' Load Boosted Ensemble Model
#'
#' This function ensures the model is downloaded and loaded when the package is used.
#' If missing, it is automatically downloaded from a stable URL.
#'
#' @importFrom utils download.file
#' @importFrom bundle bundle unbundle
#'
#' @noRd

# Internal storage for the Boosted Ensemble model
imanr_env <- new.env(parent = emptyenv())

download_model <- function() {
  # Define model storage path
  model_dir <- tools::R_user_dir("imanr", which = "data")
  model_path <- file.path(model_dir, "boosted_model_bundled.rds")

  # URL where the model is hosted (replace with your actual GitHub release link)
  model_url <- "https://github.com/rafa6174/imanr/releases/download/v2.0.0/boosted_model_bundled.rds"

  # Check if the model already exists
  if (!file.exists(model_path)) {
    packageStartupMessage("Downloading Boosted Ensemble model...")
    dir.create(model_dir, recursive = TRUE, showWarnings = FALSE)

    # Download the model
    tryCatch({
      download.file(model_url, model_path, mode = "wb")
      packageStartupMessage("Model downloaded successfully!")
    }, error = function(e) {
      stop(paste("Error downloading model:", e$message)) # Stop execution if download fails
    })
  }

  # Load the model
  packageStartupMessage("Loading Boosted Ensemble model...")
  BE_model_bundled <- readRDS(model_path)

  # Store the model in the internal environment
  imanr_env$BE_model_unbundled <- bundle::unbundle(BE_model_bundled)

  # Cleanup
  rm(BE_model_bundled)

}
