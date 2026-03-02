# ==========================================================
# Prototype Functions for Multivariate Missing Data Support
# ==========================================================

# ----------------------------------------------------------
# 1. MCAR: Missing Completely at Random
# ----------------------------------------------------------
generate_mcar_mask <- function(n, p, prop = 0.2) {
  matrix(runif(n * p) < prop, nrow = n, ncol = p)
}

# ----------------------------------------------------------
# 2. Block Missingness
# Simulates contiguous missing intervals (e.g., sensor outage)
# ----------------------------------------------------------
generate_block_mask <- function(n, p, block_size = 10) {
  mask <- matrix(FALSE, n, p)

  for (j in 1:p) {
    start <- sample(1:(n - block_size), 1)
    mask[start:(start + block_size), j] <- TRUE
  }

  return(mask)
}

# ----------------------------------------------------------
# 3. MAR-style Correlated Missingness
# Missingness depends on values exceeding a threshold
# ----------------------------------------------------------
generate_mar_mask <- function(data, threshold = 1) {
  mask <- data > threshold
  mask[is.na(mask)] <- FALSE
  return(mask)
}

# ----------------------------------------------------------
# 4. Multivariate Missing Data Generator
# ----------------------------------------------------------
sample_dat_mv <- function(data,
                          mechanism = c("mcar", "block", "mar"),
                          prop = 0.2,
                          block_size = 10,
                          threshold = 1) {

  data <- as.matrix(data)
  n <- nrow(data)
  p <- ncol(data)

  mechanism <- match.arg(mechanism)

  if (mechanism == "mcar") {
    mask <- generate_mcar_mask(n, p, prop)
  }

  if (mechanism == "block") {
    mask <- generate_block_mask(n, p, block_size)
  }

  if (mechanism == "mar") {
    mask <- generate_mar_mask(data, threshold)
  }

  data[mask] <- NA
  return(data)
}

# ----------------------------------------------------------
# Example Usage
# ----------------------------------------------------------
if (interactive()) {
  set.seed(123)
  data <- matrix(rnorm(300), ncol = 3)

  data_missing <- sample_dat_mv(
    data,
    mechanism = "mcar",
    prop = 0.2
  )

  print(head(data_missing))
}
