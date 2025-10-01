# Consistency Visualization Script
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

file_path <- "data/consistency.xlsx"
sheet_names <- excel_sheets(file_path)

all_data <- lapply(sheet_names, function(sheet) {
  df <- read_excel(file_path, sheet = sheet)
  df_long <- df %>%
    select(-Question) %>%
    summarise(across(everything(), sum)) %>%
    pivot_longer(cols = everything(), names_to = "Response", values_to = "Count") %>%
    mutate(Total = sum(Count),
           Percentage = Count / Total * 100,
           Model = sheet)
  return(df_long)
}) %>% bind_rows()

all_data$Response <- factor(all_data$Response, levels = c("Inconsistent", "Consistent"))
all_data$Model <- factor(all_data$Model, levels = sheet_names)

my_colors <- c("Inconsistent" = "#FF7F0E", "Consistent" = "#1A5276")

p <- ggplot(all_data, aes(x = Model, y = Percentage, fill = Response)) +
  geom_bar(stat = "identity", position = "stack", color = "white", linewidth = 1) +
  geom_text(aes(label = ifelse(Percentage == 0, NA, sprintf("%.2f", Percentage))),
            position = position_stack(vjust = 0.5),
            size = 2.8, color = "white", fontface = "bold") +
  scale_fill_manual(values = my_colors) +
  labs(y = "Consistency Rate (%)", x = NULL) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1,
                               size = 12, face = "bold", color = "black"),
    axis.text.y = element_text(size = 12, face = "bold", color = "black"),
    axis.title.y = element_text(size = 14, face = "bold", color = "black"),
    axis.line.x = element_line(color = "black", linewidth = 0.8),
    axis.line.y = element_line(color = "black", linewidth = 0.8),
    axis.ticks = element_line(color = "black"),
    legend.position = "none",
    panel.grid = element_blank(),
    panel.border = element_blank()
  )

ggsave("figures/consistency_plot.png", p, width = 8, height = 6, dpi = 300)
