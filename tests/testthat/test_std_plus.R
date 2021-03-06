context("Test std_plus")

test_that("Test valid data type", {

  character_input <- c("1234","cool", 5,6,7)
  v <- 2 + 5i
  complex_input <- c(v, v)
  bool_input <- c(TRUE, TRUE, FALSE)
  num_input <- c(1,1L,2,2L)

  expect_error(std_plus()) # return error if the input is empty
  expect_true(is.na(std_plus(character_input))) # expect NA if the input type is char
  expect_true(is.na(std_plus(complex_input))) # expect NA if the input type is complex
  expect_false(is.na(std_plus(bool_input))) # expect something if the input type is bool
  expect_false(is.na(std_plus(num_input))) # expect something if the input type is numeric or integer
})

test_that("Test valid data format", {
  single_input <- c(100)
  multi_input <- c(10,12,3,1,3,45,5)

  expect_error(std_plus(1,2,3,4)) # return error if the input is not a vector
  expect_true(is.na(std_plus(single_input))) # expect TRUE if the length of the input is one
  expect_length(std_plus(multi_input), 1) # expect TRUE if the length of the output is one
})

test_that("Test the correctness of std_plus", {
  zeros <- c(0,0,0,0,0)
  neg_input <- c(-112343, -123, -1234154, -6563)
  pos_input <- c(123,56524676,53245265767,134,54525)
  mix_input <- c(-123,-34,-4,0,134,5426,4555)
  inf_input <- matrix(c(0.1, 0.03, Inf, 0.4, 0.08, 0.22, 0.15, 0.55), 4)


  expect_equal(std_plus(zeros), 0) # test if all input are  0 and return the correct output
  expect_equal(std_plus(neg_input), sd(neg_input)) # test if all input are negative and return the correct output
  expect_equal(std_plus(pos_input), sd(pos_input)) # test if all input are positive and return the correct output
  expect_equal(std_plus(mix_input), sd(mix_input)) # test if input contain a mixture of neg, zero, pos numbers and return the correct output
  expect_equal(std_plus(inf_input[,1]), std_plus(inf_input[!rowSums(!is.finite(inf_input)),][,1])) # test if input has Inf, treat as missing value
})

test_that("Test the ability of handling missing values", {
  with_missing <- c(1,2,3,4,5,6,7, NA)
  without_missing <- c(1,2,3,4,5,6,7)

  expect_equal(std_plus(with_missing), std_plus(without_missing)) # expect to be equal with or without missing values
})

