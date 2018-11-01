# https://www.daum.net
# readLines("", encoding = "UTF-8")
# grep()
# gsub()
# 단순 벡터 연산(중복 제거)

text = readLines("https://www.daum.net", encoding = "UTF-8")
text = grep(pattern = "txt_issue", x = text, value = TRUE)
text = gsub(pattern = "<.*?>", replacement = "", x = text)
text

# 방법 1
unique(text)[-(1:4)]
# unique(text)[5:14]

# 방법 2
unique(text[35:length(text)])

# 방법 3
text[(1:10) * 2 + 4]

# 방법 4
text[seq(from = 6, to = 24, by = 2)]
