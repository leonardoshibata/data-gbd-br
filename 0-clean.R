library(tidyverse)


# YLL ---------------------------------------------------------------------

raw <- read.csv("raw/IHME-GBD_2019_DATA-1e6ab3f4-1.csv",
                stringsAsFactors = FALSE)

gbd <- as_tibble(raw)

saveRDS(gbd, "data/gbd.rds")


# siops -------------------------------------------------------------------

raw <- read.csv2("raw/siops.csv", skip = 3)

siops <- raw |> 
  select(-Total) |> 
  filter(UF != "Total") |> 
  pivot_longer(2:6, names_to = "year", values_to = "desp_total_saude") |> 
  mutate(year = str_remove(year, "X"))

saveRDS(siops, "data/siops.rds")



# capag -------------------------------------------------------------------

raw <- read.csv2("raw/capag-ufs-abril-2023.csv", stringsAsFactors = FALSE)

capag <- as_tibble(raw)

saveRDS(capag, "data/capag.rds")
