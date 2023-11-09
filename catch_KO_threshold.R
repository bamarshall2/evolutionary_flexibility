#!/usr/bin/env Rscript
library(dplyr)

args <- commandArgs(trailingOnly=TRUE)

message ("hello!")

files_in_directory <- list.files(path="./output_files/", full.names=TRUE)

scrape.data <- function(input_list){
  capture_all_data <- list()
  for (i in seq_along(input_list)) {
    working_data <- read.table(file = input_list[[i]], sep='\t', col.names=c("*","gene_name","KO","thrshld","score","E-value","KO_definition"))
    print(working_data)
    working_data$genome <- input_list[[i]]
    capture_all_data [[i]]<- working_data
  }
  dplyr::bind_rows(capture_all_data)
}

scraped_data <- scrape.data(files_in_directory)

write.csv(scraped_data %>% group_by(genome,KO) %>% summarize(max=max(score)),"./results/caught_KO_threshold_genes.csv")




