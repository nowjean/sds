bike = read.csv("bike.csv", stringsAsFactors = FALSE)
bike = bike[, -c(1, 11, 12)]
head(bike)

train = bike[1:4000, ]
test  = bike[4001:nrow(bike), ]

model = lm(casual ~ ., data = train)
summary(model)

# Q1. 상관계수
# Q1-1) train 객체의 변수 중 상관계수가 가장 높은 변수 쌍을 기술하시오.
# ex. A 변수, B 변수
round(cor(train), 2)
library("corrplot")
corrplot(cor(train))

# temp, atemp

# Q1-2) Q1-1에서 확인한 변수 쌍으로 상관분석을 실시하고
# 상관계수 및 p-value를 기술하시오
# (단, 소수 넷 째 자리에서 반올림 한다.)
result = cor.test(train$temp, train$atemp)
round(result$estimate, 3)
round(result$p.value, 3)


# Q2. 변수 제거
# Q2-1) 변수 중 p-value가 가장 높은 변수 명과 p-value를 기술하시오.
# (단, 소수 넷 째 자리에서 반올림 한다.)
summary(model)

model_s = summary(model)
model_s$coefficients

max = which.max(model_s$coefficients[, 4])

rownames(model_s$coefficients)[max]
round(model_s$coefficients[max, 4], 3)



# Q2-2) Q2-1에서 확인한 p-value값이 가장 높은 변수를 제외하고 
#       다중 선형 회귀 분석을 재실시 하시오.
#       이 때, 결정계수는 얼마인가?
# (단, 소수 넷 째 자리에서 반올림 한다.)
model2 = lm(casual ~ . -season, data = train)
summary(model2)


# Q3. 예측력 확인
pred = predict(model, newdata = test)
test[, "pred"] = pred
test[, "diff"] = test$casual - test$pred
head(test[, -(1:4)])
sum(test$diff)
sum(abs(test$diff))
sum(sqrt(test$diff^2))
