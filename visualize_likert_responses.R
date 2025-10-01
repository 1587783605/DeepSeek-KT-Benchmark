# Likert Rating Visualization Script
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

files <- c("data/readability.xlsx", "data/comprehensiveness.xlsx")
for (file in files) {
  df <- read_excel(file, sheet = 1)
  df_clean <- df[, 1:7]
  colnames(df_clean) <- c("QuestionID", "Question", "Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree")

  df_long <- df_clean %>%
    pivot_longer(
      cols = c("Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"),
      names_to = "Response", values_to = "Count"
    ) %>%
    group_by(QuestionID) %>%
    mutate(Total = sum(Count),
           Percentage = Count / Total) %>%
    ungroup() %>%
    mutate(Response = factor(Response,
                             levels = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")))

  name <- ifelse(grepl("readability", file), "readability", "comprehensiveness")

  p <- ggplot(df_long, aes(x = QuestionID, y = Percentage, fill = Response)) +
    geom_bar(stat = "identity", position = "fill", width = 0.7) +
    scale_y_continuous(labels = percent_format(accuracy = 1)) +
    scale_fill_brewer(palette = "RdYlGn", direction = 1) +
    labs(
      title = paste0(name, " Likert Score Distribution"),
      x = "Question ID",
      y = "Percentage",
      fill = "Response"
    ) +
    theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "right"
    )

  ggsave(paste0("figures/", name, "_likert_chart.png"), p, width = 8, height = 6, dpi = 300)
}
