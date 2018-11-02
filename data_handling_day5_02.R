# Q. 데이터 처리 및 병합 실습
# bike_weather.csv 데이터에 bike_rental.csv를 left join 하여
# 새로운 객체 bike를 생성하시오.
# (단, 시간과 관련된 변수를 모두 사용해야 한다.)

rental = read.csv("bike_rental.csv", stringsAsFactors = FALSE)
head(rental)
weather = read.csv("bike_weather.csv", stringsAsFactors = FALSE)
head(weather)

library("lubridate")
rental[, "date"] = date(rental$datetime)
rental[, "hour"] = hour(rental$datetime)
rental[, "date"] = as.character(rental$date)
# class(weather[, "date"]) == class(rental[, "date"])

library("dplyr")
bike = left_join(weather, rental, by = c("date" = "date", 
                                         "hour" = "hour"))
head(bike)

# Q. 선형 회귀
# 종속변수: registered
# 독립변수: hour, temp, workingday
# 기존에 생성한 bike 객체를 활용하여 위에 나열한 변수를 기준으로
# 다중선형회귀 분석을 실시하시오.
model = lm(registered ~ hour + temp + workingday, data = bike)
summary(model)

# 이 모델의 결정계수 값을 소수 넷 째 자리에서 반올림하여
# 소수 셋 째 자리까지 기술하시오.
round(0.2278, 3)

# p-value가 0.01 미만인 변수는 몇 개인가?
# 3


