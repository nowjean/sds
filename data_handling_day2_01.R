df = data.frame(aa = c(1:7, "a"),
                bb = 1:8)
head(df)
df[, "aa2"] = df$aa * 2 # 안됨
class(df$aa) # factor(즉, 변환 필요)
df$aa
df[8, "aa"] = 8 # factor 때문에 NA 생성
df[, "aa"] = as.character(df$aa) # fac -> chr
class(df$aa)
df[is.na(df$aa), "aa"] = 8
df[, "aa2"] = df$aa * 2 # 안됨
class(df$aa) # 문자임...
df[, "aa"] = as.numeric(df$aa)
class(df$aa)
df[, "aa2"] = df$aa * 2 # 된다!!!
df
