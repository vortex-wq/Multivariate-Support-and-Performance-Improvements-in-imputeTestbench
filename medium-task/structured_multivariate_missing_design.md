# Medium Task  
## Structured Missing Data Simulation for Multivariate Time Series

---

## 1. Objective

The objective of this proposal is to extend the `imputeTestbench` package to support structured missing data simulation for **multivariate time series**, while preserving backward compatibility with existing univariate workflows.

Currently, `imputeTestbench` operates primarily on univariate time series. This proposal introduces a systematic and extensible approach to simulate structured missingness across multiple variables.

---

## 2. Design Overview

To support multivariate time series, the following extensions are proposed:

- Accept matrix or data.frame inputs (rows = time, columns = variables)
- Generate structured missingness masks as logical matrices
- Support multiple missing data mechanisms
- Maintain compatibility with existing functions

The missing data structure will be represented using a logical matrix:

- `TRUE` → value becomes NA  
- `FALSE` → value remains observed  

Dimensions:  
`n × p`  
where:
- `n` = number of time points  
- `p` = number of variables  

---

## 3. Missing Data Mechanisms

### A. MCAR (Missing Completely at Random)

Random missingness independently across variables.

```r
generate_mcar_mask <- function(n, p, prop) {
  matrix(runif(n * p) < prop, nrow = n, ncol = p)
}
