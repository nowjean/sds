text = c("1234_asdf", 
         "dd_ddd_1234")

# 방법 1
reg = regmatches(x = text,
                 m = gregexpr(pattern = "[a-z]{3,4}",
                              text = text))
unlist(reg)

# Q. 파이프라인 연산자(%>%)를 활용하여 
# 방법 1과 같은 결과를 출력하시오.
text %>%
  gregexpr(pattern = "[a-z]{3,4}") %>%
  regmatches(x = text) %>%
  unlist()
