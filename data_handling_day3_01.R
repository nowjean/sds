data("Orange")
head(Orange)

set.seed(1228)
df = as.matrix(Orange)
df[sample(1:(nrow(df) * ncol(df)), size = 10)] = NA
df = as.data.frame(df)
head(df, 3)

df[is.na(df$Tree),]

# Q1. 하나의 관측치(row)에 두 개 이상의 결측(NA)을 보이는 행을 제거.
# 방법 1) 논리 연산 활용
df[(is.na(df$Tree) & is.na(df$age) |
     (is.na(df$age) & is.na(df$circumference)) | 
     (is.na(df$Tree) & is.na(df$circumference))), ]

df_sub = df[!(is.na(df$Tree) & is.na(df$age) |
              (is.na(df$age) & is.na(df$circumference)) | 
              (is.na(df$Tree) & is.na(df$circumference))), ]

# 방법 2) ifelse() + apply() 활용
# 방법 2-1)
df[, "Tree_na"] = ifelse(test = is.na(df$Tree), yes = 1, no = 0)
df[, "age_na"]  = ifelse(test = is.na(df$age) , yes = 1, no = 0)
df[, "circumference_na"] = ifelse(test = is.na(df$circumference), yes = 1, no = 0)
head(df)

df[, "na_cnt"] = apply(df[, 4:6], MARGIN = 1, FUN = "sum")
head(df)

# 방법 2-2) + for() 함수
for(n in 1:ncol(df)){
  df[, paste0(colnames(df)[n], "_na")] = ifelse(test = is.na(df[, n]),
                                                yes = 1, no = 0)  
}
df[, "na_cnt"] = apply(df[, 4:6], MARGIN = 1, FUN = "sum")
head(df)


# 방법 3) apply() + 사용자 정의 함수 활용
# 방법 3-1) 
df[, "na_cnt"] = apply(df, MARGIN = 1, FUN = function(x){sum(is.na(x))})
head(df)

# 방법 3-2)
na_cnt = function(x){
  sum(is.na(x))
}
df[, "na_cnt"] = apply(df, MARGIN = 1, FUN = "na_cnt")
head(df)

# Q2. Q1의 결과 값을 사용하여 다음 문제를 해결하시오.
#   - age 변수에 있는 결측 값을 1000으로 치환하고
#     해당 변수의 값을 모두 더하시오.

# df_sub[is.na(df_sub$age), "age"] = 1000
sapply(df_sub, "class")
df_sub[, "age"] = as.numeric(as.character(df_sub$age))
df_sub[is.na(df_sub$age), "age"] = 1000
summary(df_sub)

# 결측 확인 방법 1
sum(is.na(df_sub$age))

# 결측 확인 방법 2
nrow(df_sub[is.na(df_sub$age), ])


# Q3. 전체 데이터에서 Q1에서 제거된 행의 비율을 
#     소수 셋 째 자리까지 반올림하여 계산하시오.
round((nrow(df) - nrow(df_sub))/nrow(df), 3)
