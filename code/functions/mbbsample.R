## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for obtaining a block bootstrap sample

mbbsample <- function(data, b){
  
  ## data: the time series as a vector
  ## b: the integer block length
  
  # Compute the length of the data
  n <- length(data)
  
  # Compute the number of blocks
  m <- n - b + 1
  
  # Create the blocks
  blocks <- matrix(numeric(b * m), ncol = b)
  
  # Fill in the blocks
  for(i in 1:m){
    blocks[i,] <- data[i:(b + i - 1)]
  }
  
  # Compute the number of blocks to sample
  k <- floor(n / b)
  
  # Sample the block numbers
  block_numbers <- sample(1:m, k, replace = TRUE)
  
  # Grab the appropriate blocks
  bb_sample <- as.vector(blocks[block_numbers,])

  # Return the block bootstrap sample
  return(bb_sample)
  
}

