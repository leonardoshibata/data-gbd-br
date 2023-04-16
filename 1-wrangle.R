# daly <- gbd |> 
#   filter(measure == "DALYs (Disability-Adjusted Life Years)",
#          year == "2019") |> 
#   select(location, age, cause, metric, year, val, upper, lower)

library(tidyverse)

# YLL ---------------------------------------------------------------------

gbd <- readRDS("data/gbd.rds")

asyr2019 <- gbd |> 
  filter(measure == "YLLs (Years of Life Lost)",
         age == "Age-standardized",
         year == "2019") |> 
  select(location, cause, year, val, upper, lower)

yll2019 <- gbd |> 
  filter(measure == "YLLs (Years of Life Lost)",
         age == "All ages",
         metric == "Number",
         year == "2019") |> 
  select(location, cause, year, val, upper, lower)



# siops -------------------------------------------------------------------

siops2019 <- siops |>
  filter(year == "2019") |> 
  rename(location = UF)



# YLL vs SIOPS ------------------------------------------------------------

yll_siops <- left_join(yll2019, siops2019, by = "location") |> 
  select(-year.y) |> 
  rename(year = year.x)
