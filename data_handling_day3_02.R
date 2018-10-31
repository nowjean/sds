
#### Q ####
#### 1. 결측치 확인 ####
# 각 column의 결측치를 확인하시오.
# 각 column별 결측치 개수를 모두 더하시오.
summary(df)

# 방법 1
sum(sapply(df, FUN = function(x){sum(is.na(x))}))

# 방법 2
sum(is.na(df[, 1]))

na_cnt = c()
for(n in 1:ncol(df)){
  na_cnt[n] = sum(is.na(df[, n]))
}
sum(na_cnt)


#### 2. 단변수 탐색 ####
#### __ 1) 예약(is_booking) 비율을 계산 ####
# 방법 1
sum(df$is_booking == 1)/nrow(df)

# 방법 2
df_sub = df[df$is_booking == 1, ]
nrow(df_sub)/nrow(df)

#### __ 2) 각 변수별 원소의 빈도 확인 ####
#### ____ (1) site_name ####
table(df$site_name)

#### ____ (2) user_location_country ####
table(df$user_location_country)

#### ____ (3) hotel_country ####
table(df$hotel_country)

#### __ 3) 각 변수별 원소의 비율 확인 ####
# ※ 상위 3개를 추출하고 그 비율을 백분율로 표기하시오
#    (단, 소수 둘 째 자리에서 반올림 할 것)
#### ____ (1) site_name ####
# 방법 1
props = round(prop.table(table(df$site_name)) * 100, 1)
props[order(-props)][1:3]

ordered_props = props[order(-props)]
ordered_props[1:3]

# 방법 2
df_props = as.data.frame(prop.table(table(df$site_name)))
df_props[, "Freq"] = round(df_props$Freq * 100, 2)
df_props = df_props[order(-df_props$Freq), ]
df_props[1:3, ]
head(df_props)

# 방법 3
library("magrittr")
df$site_name %>%
  table() %>%
  prop.table() %>%
  `*`(100) %>%
  round(1) %>% 
  .[order(-.)] %>%
  `[`(1:3)


#### ____ (2) user_location_country ####
#### ____ (3) hotel_country ####


#### 3. 이변수 탐색 ####
head(df)

#### __ 1) 예약 x 모바일 ####
# 모바일 접속자의 예약 비율과
# 모바일로 접속하지 않은 사람의 계산하시오.
df_m_0 = df[df$is_mobile == 0,] 
df_m_1 = df[df$is_mobile == 1,] 

sum(df_m_0$is_booking == 1) / nrow(df_m_0)
sum(df_m_1$is_booking == 1) / nrow(df_m_1)

# 모바일로 접속한 사람과 그렇지 않은 사람의 예약 비율을 검정하시오.
prop.test(c(sum(df_m_0$is_booking == 1), sum(df_m_1$is_booking == 1)),
          c(nrow(df_m_0), nrow(df_m_1)))


#### __ 2) 예약 x 국가 ####
#### ____ (1) 변수 생성 ####
# 사용자의 국가와 여행하는 국가의 일치 여부를 확인하는
# 변수를 새로 생성하시오.
df[, "domestic"] = ifelse(df$user_location_country == df$hotel_country,
                          yes = 1, no = 0)

#### ____ (2) 확인 ####
# (사용자 기준) 국내 여행을 검색한 사람의 예약비율과
#               해외 여행을 검색한 사람의 예약비율을 구하시오.
df_d_1 = df[df$domestic == 1, ]
df_d_0 = df[df$domestic == 0, ]

sum(df_d_1$is_booking == 1) / nrow(df_d_1)
sum(df_d_0$is_booking == 1) / nrow(df_d_0)
