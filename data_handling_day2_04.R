#### handling class_scores.csv ####

score = read.csv("class_scores.csv", stringsAsFactors = FALSE)
head(score)

df_subject = data.frame(subject = colnames(score)[5:ncol(score)],
                        mean = apply(score[, 5:ncol(score)], MARGIN = 2, FUN = "mean"),
                        max  = apply(score[, 5:ncol(score)], MARGIN = 2, FUN = "max"),
                        min = apply(score[, 5:ncol(score)], MARGIN = 2, FUN = "min"))
df_subject

df_subject["English", ]
rownames(df_subject) = NULL
df_subject
