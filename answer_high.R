options(stringsAsFactors = FALSE)

df1 = read.csv("highway_01_07.csv", encoding = "UTF-8")
df2 = read.csv("highway_08_12.csv", encoding = "UTF-8")
head(df1)
head(df2)

df_location = data.frame(StartPoint = unique(df2$StartPoint),
                         StartPoint_en = c("Gangwon", "Gyeonggi", "Gyeongsang",
                                           "Jeolla", "Chungcheong"))

library("dplyr")
df2 = left_join(df2, df_location, by = c("StartPoint" = "StartPoint"))
df2 = df2[, c(1, 8, 3:7)]
colnames(df2)[2] = "StartPoint"
head(df2)

df = rbind(df1, df2)
head(df)

# 방법 1
df_sub = df[df$StartPoint == "Gangwon",]
quantile(as.matrix(df_sub[, 3:7]))

# 방법 2
library("reshape2")
df_melt = melt(data = df, id.vars = c("date", "StartPoint"),
               variable.name = "EndPoint", value.name = "traffic")
head(df_melt)

quantile(df_melt[df_melt$StartPoint == "Gangwon", "traffic"])
summary(df_melt[df_melt$StartPoint == "Gangwon", "traffic"])

# (2)
df_melt1 = df_melt[(df_melt$StartPoint == "Gyeonggi") & 
                     (df_melt$EndPoint == "Gyeongsang"),]
df_melt2 = df_melt[(df_melt$StartPoint == "Gyeongsang") & 
                     (df_melt$EndPoint == "Gyeonggi"),]
head(df_melt1)
head(df_melt2)

dd = t.test(df_melt1$traffic, df_melt2$traffic)
dd$p.value
# 0.0013
# YES

# (3)
head(df_melt)
library("lubridate")

# 방법 1
df_melt[, "date"] = as.POSIXct(strptime(df_melt$date,
                                        format = "%Y%m%d"))
df_melt[, "month"] = month(df_melt$date)
df_melt[, "weekday"] = weekdays(df_melt$date)
head(df_melt)

# 방법 2
# weekdays(ymd(20140101))
# month(ymd(20140101))

# ===============

df_agg = aggregate(data = df_melt, traffic ~ month + weekday,
                   FUN = "mean")
head(df_agg)
traffic_min = min(df_agg$traffic)
traffic_max = max(df_agg$traffic)

df_agg[, "traffic_norm"] = (traffic_max - df_agg$traffic) / (traffic_max - traffic_min)
head(df_agg)
summary(df_agg)

set.seed(1)
cluster = kmeans(df_agg$traffic, centers = 3, iter.max = 100)

df_agg[, "cluster"] = cluster$cluster
head(df_agg)
df_agg_mon = df_agg[df_agg$weekday == "월요일", ]
df_agg_mon
sum(df_agg_mon$cluster == 3)

