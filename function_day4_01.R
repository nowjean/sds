bbb = function(x, y){
  plot(x, y)
  print(sum(x, y))
  print(sum(x^2, y^2))
}
bbb(2, 2)
pp = bbb(2, 2)

ccc = function(x, y){
  plot(x, y)
  # result = c(sum(x, y), sum(x^2, y^2))
  result = list(sum(x, y), sum(x^2, y^2))
  return(result)
}
oo = ccc(2, 2)
oo[[1]]
