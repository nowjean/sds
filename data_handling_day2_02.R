#### handling elec_load.csv ####

# 정규 표현식을 모를 경우.
df = read.csv("elec_load.csv", stringsAsFactors = FALSE)
library("reshape2")
df_melt = melt(data = df, id.vars = colnames(df)[1:3])
df_melt[, "variable"] = as.character(df_melt$variable)

df_melt[, "chr_cnt"] = nchar(df_melt$variable)
df_melt[df_melt$chr_cnt == 4, "variable"] = substr(df_melt[df_melt$chr_cnt == 4, "variable"],
                                                   start = 2, stop = 2)
df_melt[df_melt$chr_cnt == 5, "variable"] = substr(df_melt[df_melt$chr_cnt == 5, "variable"],
                                                   start = 2, stop = 3)
df_melt[, "variable"] = as.numeric(df_melt[, "variable"])
head(df_melt)

# 정규 표현식을 아는 경우 
df = read.csv("elec_load.csv", stringsAsFactors = FALSE)
library("reshape2")
df_melt = melt(data = df, id.vars = colnames(df)[1:3])
df_melt[, "variable"] = gsub(pattern = "[^0-9]", replacement = "",
                             x = df_melt$variable)
df_melt[, "variable"] = as.numeric(df_melt$variable)
head(df_melt)
tail(df_melt)
