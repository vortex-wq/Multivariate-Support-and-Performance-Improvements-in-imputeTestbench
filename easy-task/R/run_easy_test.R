# Easy Test for imputeTestbench
# Author: Vaastavi
# Description: Basic imputation comparison using default settings

# Install package if not installed
if (!require(imputeTestbench)) {
  install.packages("imputeTestbench", repos="https://cloud.r-project.org")
  library(imputeTestbench)
}

# Load built-in dataset
data(nottem)

# Run imputation comparison
result <- impute_errors(dataIn = nottem)

# Save numeric results
write.csv(result, file = "results/easy_test_results.csv", row.names = FALSE)

# Save text summary
capture.output(print(result),
               file = "results/easy_test_summary.txt")

# Save plot
png("plots/easy_test_plot.png", width = 800, height = 600)
plot_errors(result, plotType = "line")
dev.off()

cat("Easy test completed successfully!\n")
