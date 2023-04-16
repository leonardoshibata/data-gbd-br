# # Explore DALY
# error_margins <- daly |>
#   filter(location == "Brazil") |> 
#   select(lower, upper) |> unlist()
# 
# daly2 <- daly |> 
#   left_join(read.csv2(file = "raw/capag-ufs-abril-2023.csv",stringsAsFactors = FALSE)) |> 
#   mutate(capag = replace_na(capag, ""))
# 
# daly2 |>
#   mutate(location = fct_reorder(location, val)) |>  #ordena de acordo com a média
#   ggplot() +
#   geom_rect(aes(xmin=error_margins[1], xmax=error_margins[2], ymin=-Inf, ymax=+Inf), fill='lightgrey', alpha = 0.005)+
#   geom_point(aes(x = val, y = location, color = capag))+
#   geom_segment(aes(x = lower, xend = upper, y = location, yend = location), linewidth = 0.1)+
#   theme_classic()


library(tidyverse)
library(ggrepel)


# Explore ASYR ------------------------------------------------------------

error_margins <- asyr2019 |>
  filter(location == "Brazil") |> 
  select(lower, upper) |> unlist()

error_margins[1]
error_margins[2]

capag <- readRDS("data/capag.rds")

asyr2 <- left_join(asyr2019, capag) |> 
  mutate(
    # capag = replace_na(capag, ""),
         condicao = ifelse(capag %in% c("A", "B"), TRUE, FALSE))

asyr2 |>
  mutate(location = fct_reorder(location, val)) |>  #ordena de acordo com a média
  ggplot() +
  geom_rect(aes(xmin=error_margins[1], xmax=error_margins[2], ymin=-Inf, ymax=+Inf), fill='lightgrey', alpha = 0.005)+
  geom_point(aes(x = val, y = location, color = condicao))+
  geom_segment(aes(x = lower, xend = upper, y = location, yend = location), linewidth = 0.1)+
  theme_classic()




# Explore Siops vs. YLL ---------------------------------------------------

yll_siops |> 
  ggplot(aes(x = val, y = desp_total_saude))+
  geom_smooth(method=lm , color="red", fill="#69b3a2", se=TRUE)+
  geom_point()+
  geom_text_repel(aes(label = location))+
  scale_x_log10() + scale_y_log10()
