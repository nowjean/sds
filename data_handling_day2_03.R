#### handling rating_ramyun.csv ####
# 벡터연산만 아는 경우
df = read.csv("rating_ramyun.csv", stringsAsFactors = FALSE)
df[, "kr"] = 0
df[df$Country == "South Korea", "kr"] = 1

# for() 반복문과 if() 함수를 아는 경우
df = read.csv("rating_ramyun.csv", stringsAsFactors = FALSE)
for(n in 1:nrow(df)){
  if(df[n, "Country"] == "South Korea"){
    df[n, "kr"] = 1
  } else {
    df[n, "kr"] = 0
  }
}

# ifelse()를 아는 경우
df = read.csv("rating_ramyun.csv", stringsAsFactors = FALSE)
df[, "kr"] = ifelse(test = df$Country == "South Korea", yes = 1, no = 0)
