# gen lin @ Slack, reverse yaxis
plot_ly(iris) %>% 
add_lines(x=~Sepal.Width,y=~Sepal.Length) %>% 
layout(yaxis=list(autorange="reversed"))
##
plot_ly(fcc) %>% add_lines(x=~Ymd,y=~Yhat) %>%
  add_lines(data=A,x=~Ymd,y=~MA) %>%
  layout(yaxis=list(autorange="reversed"))

