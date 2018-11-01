
time_line = seq(from = as.POSIXct("2018-01-01 00:00:00"),
                to   = as.POSIXct("2018-03-31 23:59:59"),
                by = "30 sec")
head(time_line)

df = data.frame(obs = 1:length(time_line),
                time = time_line,
                year = year(time_line),
                month = month(time_line),
                day = day(time_line),
                weekday = weekdays(time_line))
head(df)

df[, "value"] = rnorm(nrow(df), mean = 3)
head(df)

# 방법 1
df[, "date"] = date(df$time)
df_agg = aggregate(data = df, value ~ date, FUN = "mean")
head(df_agg)

# 방법 2
df_agg = aggregate(data = df, value ~ year + month + day,
                   FUN = "mean")
head(df_agg)

df_agg[, "weekday"] = weekdays(df_agg$date)
df_agg[, "weight"] = ifelse(test = df_agg$weekday == "월요일",
                            yes = 1,
                            no = 0)
head(df_agg)

# 방법 3
df_agg = aggregate(data = df, value ~ date(time) + weekday,
                   FUN = "mean")
head(df_agg)
