# gen lin @ Slack, reverse yaxis
plot_ly(iris) %>% 
add_lines(x=~Sepal.Width,y=~Sepal.Length) %>% 
layout(yaxis=list(autorange="reversed"))
##
plot_ly(fcc) %>% add_lines(x=~Ymd,y=~Yhat) %>%
  add_lines(data=A,x=~Ymd,y=~MA) %>%
  layout(yaxis=list(autorange="reversed"))

## kent.johnson @ Slack rading file names into R.
Break up the code so you capture the result of choose.files. 
Then use basename to get the name of the file. E.g.

path = choose.files()
name = basename(path)
betelguese = fread(path)

## Example of Plotly scatter plot. with added lines

just.stats %>% plot_ly(x=~Month,y=~Mean,name="Mean",type="scatter",mode="markers") %>%
        add_lines(x=~Month,y=~Brighter,name="Brighter") %>%
        add_lines(x=~Month,y=~Fainter,name="Fainter")
