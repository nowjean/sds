df = read.csv("Antibiotic_70M_patinets.csv",
              stringsAsFactors = FALSE)
head(df)
summary(df)

df_agg = aggregate(data = df, high_p ~ age_5, FUN = "mean")
df_agg[df_agg$high_p == max(df_agg$high_p), ]

sum(sapply(df, FUN = function(x){sum(is.na(x))}))
summary(df)

# df_num = df[df$total_d > qgamma(p = 0.98, shape = 1, scale = 10), ]
head(df_num)

limit = qgamma(p = 0.98, shape = 1, scale = 10)
df[df$total_d > limit, "total_d"] = limit

cor.test(df$age_5, df$high_p)


df_cdiff1 = df[df$cdiff == 1, ]
df_cdiff0 = df[df$cdiff == 0, ]

round(abs(mean(df_cdiff0$high_p) - mean(df_cdiff1$high_p)), 2)
t.test(df_cdiff0$high_p, df_cdiff1$high_p)

head(df)
model = glm(cdiff ~ . -ID, family = "binomial", data = df)
summary(model)
