# R-Snippets
Collection of R  language code snippets
## Slack R for Data Science Commuity

Is there a way to filter() or select() based on column type? I.E.  I only want to pull columns that are type numeric ?

#### Adrian Fletcher
iris %>%
    filter(across(.cols = Sepal.Length, is.numeric))
 * Shows all rows that are numeric in Sepal.Length
 * use everything() to select all columns

#### Emil Malta
where  is also a good select helper function to know
starwars %>% select(where(is.numeric))

#### Alun Hewinson 
select_if(iris, is.numeric)
select_if(iris, is.factor)

#### Shea Fyffe
your_data[vapply(your_data, FUN = is.numeric, FUN.VALUE = logical(1))]
