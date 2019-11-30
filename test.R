library(datasets)
library(ggplot2)
library(hrbrthemes)

htwt<- read.csv("/Users/sebastianpycior/sebasportfolio/content/post/htwt.csv", header = TRUE, stringsAsFactors = FALSE)

bmi<- read.csv("/Users/sebastianpycior/sebasportfolio/content/post/bmi_speed.csv", header = TRUE, stringsAsFactors = FALSE)

htwt<-htwt[rep(seq_len(nrow(htwt)), each = 2), ]

write.csv(htwt, file = "/Users/sebastianpycior/sebasportfolio/content/post/htwt_double.csv")
#***add All to every other row under team column***#
htwt_double<-read.csv("/Users/sebastianpycior/sebasportfolio/content/post/htwt_double.csv", header = TRUE, stringsAsFactors = FALSE)

htwt_double <- htwt_double[order(htwt_double$Team),]


####Kmeans analysis htwt####
htwt.kmeans <- lapply(1:20, function(ii) {
  kmeans(htwt[,c("BMI")], centers = ii)
})
lapply(htwt.kmeans, function(xx) xx$withinss)

htwt.within.ss <- sapply(htwt.kmeans, function(xx) sum(xx$withinss))

ggplot(data.frame(cluster = 1:20, within.ss = htwt.within.ss), aes(cluster, within.ss)) +
  geom_point() + geom_line() +
  scale_x_continuous(breaks = 0:20)


ggplot(htwt, aes(Wt.kg, Ht.m))+
  geom_point()+
  theme_ipsum()+ theme(legend.position = "none",panel.grid.minor = element_blank())

####Kmeans analysis bmi####
res.kmeans <- lapply(1:20, function(i) {
  kmeans(bmi[,c("z.BMI","z.Speed")], centers = i)
})
lapply(res.kmeans, function(x) x$withinss)

res.within.ss <- sapply(res.kmeans, function(x) sum(x$withinss))

ggplot(data.frame(cluster = 1:20, within.ss = res.within.ss), aes(cluster, within.ss)) +
  geom_point() + geom_line() +
  scale_x_continuous(breaks = 0:20)
####Plotly BMI analysis####
bmi$Team <- factor(bmi$Team, labels = )

features <- c('z.BMI', 'z.Speed')
n_clusters <- 9
pl_clusters <- kmeans(bmi[, features], n_clusters, nstart = 100)

bmi$cluster <- factor(pl_clusters$cluster)

centroids <- data.frame(cluster = factor(seq(1:n_clusters)),
                        z.BMI = pl_clusters$centers[,'z.BMI'],
                        z.Speed = pl_clusters$centers[,'z.Speed'])

print(table(bmi$cluster, bmi$Team))

g <- ggplot() + 
  geom_text(data = bmi,
            aes(x = z.BMI,
                y = z.Speed,
                label = RName,
                color = cluster),
            nudge_y = .2, nudge_x = -.2, size = 3.25,
            check_overlap = TRUE) +
  geom_point(data = bmi, 
             aes(x = z.BMI, 
                 y = z.Speed,
                 color = cluster),
             size = 1, alpha=1/5) +
  geom_point(data = centroids,
             mapping = aes(x = z.BMI,
                           y = z.Speed,
                           color = cluster),
             size = 5,
             pch = 13)+
  theme_ipsum()+ theme(legend.position = "none",panel.grid.minor = element_blank())
g


####HTWT PLOTLY####
library(plotly)    

p <- htwt_double %>%
  plot_ly(
    type = 'scatter', 
    x = ~Wt.kg, 
    y = ~Ht.m,
    text = ~paste("Player: ", Name,'<br>Pos.:', Pos., '<br>Height:', Ht.m, 'm', '<br>Weight:', Wt.kg, 'kg', '<br>BMI:', BMI),
    color = ~Team,
   colors =  c("#1D4289",
               "#E03A3E",
               "#007A33",
               "#1D1160",
               "#CE1141",
               "#6F263D",
               "#00538C",
               "#0E2240",
               "#C8102E",
               "#1D428A",
               "#CE1141",
               "#002D62",
               "#C8102E",
               "#552583",
               "#5D76A9",
               "#98002E",
               "#00471B",
               "#0C2340",
               "#0C2340",
               "#F58426",
               "#EF3B24",
               "#0077C0",
               "#006BB6",
               "#1D1160",
               "#E03A3E",
               "#5A2D81",
               "#C4CED4",
               "#B4975A",
               "#753BBD",
               "#002B5C"),
    hoverinfo = 'text',
    mode = 'markers', 
    transforms = list(
      list(
        type = 'filter',
        target = ~Team,
        operation = '=',
        value = unique(htwt_double$Team)[1]
      )
    )) %>% layout(
      showlegend = FALSE,
      updatemenus = list(
        list(
          type = 'dropdown',
          active = 0,
          buttons =list(
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[1]),
                 label = unique(htwt_double$Team)[1]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[2]),
                 label = unique(htwt_double$Team)[2]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[3]),
                 label = unique(htwt_double$Team)[3]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[4]),
                 label = unique(htwt_double$Team)[4]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[5]),
                 label = unique(htwt_double$Team)[5]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[6]),
                 label = unique(htwt_double$Team)[6]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[7]),
                 label = unique(htwt_double$Team)[7]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[8]),
                 label = unique(htwt_double$Team)[8]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[9]),
                 label = unique(htwt_double$Team)[9]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[10]),
                 label = unique(htwt_double$Team)[10]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[11]),
                 label = unique(htwt_double$Team)[11]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[12]),
                 label = unique(htwt_double$Team)[12]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[13]),
                 label = unique(htwt_double$Team)[13]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[14]),
                 label = unique(htwt_double$Team)[14]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[15]),
                 label = unique(htwt_double$Team)[15]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[16]),
                 label = unique(htwt_double$Team)[16]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[17]),
                 label = unique(htwt_double$Team)[17]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[18]),
                 label = unique(htwt_double$Team)[18]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[19]),
                 label = unique(htwt_double$Team)[19]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[20]),
                 label = unique(htwt_double$Team)[20]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[21]),
                 label = unique(htwt_double$Team)[21]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[22]),
                 label = unique(htwt_double$Team)[22]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[23]),
                 label = unique(htwt_double$Team)[23]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[24]),
                 label = unique(htwt_double$Team)[24]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[25]),
                 label = unique(htwt_double$Team)[25]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[26]),
                 label = unique(htwt_double$Team)[26]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[27]),
                 label = unique(htwt_double$Team)[27]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[28]),
                 label = unique(htwt_double$Team)[28]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[29]),
                 label = unique(htwt_double$Team)[29]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[30]),
                 label = unique(htwt_double$Team)[30])
          )
        )
      )
    )
p

#############below definitely works
library(plotly)    

htwt_double<-read.csv("/Users/sebastianpycior/sebasportfolio/content/post/htwt_double.csv", header = TRUE, stringsAsFactors = FALSE)

htwt_double <- htwt_double[order(htwt_double$Team),]


p <- htwt_double %>%
  plot_ly(
    type = 'scatter', 
    x = ~Wt.kg, 
    y = ~Ht.m,
    text = ~paste("Player: ", Name,'<br>Pos.:', Pos., '<br>Height:', Ht.m, 'm', '<br>Weight:', Wt.kg, 'kg', '<br>BMI:', BMI),
    color = ~Team,
    colors =  c("#1D4289",
                "#E03A3E",
                "#007A33",
                "#1D1160",
                "#CE1141",
                "#6F263D",
                "#00538C",
                "#0E2240",
                "#C8102E",
                "#1D428A",
                "#CE1141",
                "#002D62",
                "#C8102E",
                "#552583",
                "#5D76A9",
                "#98002E",
                "#00471B",
                "#0C2340",
                "#0C2340",
                "#F58426",
                "#EF3B24",
                "#0077C0",
                "#006BB6",
                "#1D1160",
                "#E03A3E",
                "#5A2D81",
                "#C4CED4",
                "#B4975A",
                "#753BBD",
                "#002B5C"),
    hoverinfo = 'text',
    mode = 'markers', 
    transforms = list(
      list(
        type = 'filter',
        target = ~Team,
        operation = '=',
        value = unique(htwt_double$Team)[1]
      )
    )) %>% layout(
      showlegend = FALSE,
      updatemenus = list(
        list(
          type = 'dropdown',
          active = 0,
          buttons =list(
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[1]),
                 label = unique(htwt_double$Team)[1]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[2]),
                 label = unique(htwt_double$Team)[2]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[3]),
                 label = unique(htwt_double$Team)[3]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[4]),
                 label = unique(htwt_double$Team)[4]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[5]),
                 label = unique(htwt_double$Team)[5]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[6]),
                 label = unique(htwt_double$Team)[6]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[7]),
                 label = unique(htwt_double$Team)[7]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[8]),
                 label = unique(htwt_double$Team)[8]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[9]),
                 label = unique(htwt_double$Team)[9]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[10]),
                 label = unique(htwt_double$Team)[10]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[11]),
                 label = unique(htwt_double$Team)[11]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[12]),
                 label = unique(htwt_double$Team)[12]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[13]),
                 label = unique(htwt_double$Team)[13]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[14]),
                 label = unique(htwt_double$Team)[14]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[15]),
                 label = unique(htwt_double$Team)[15]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[16]),
                 label = unique(htwt_double$Team)[16]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[17]),
                 label = unique(htwt_double$Team)[17]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[18]),
                 label = unique(htwt_double$Team)[18]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[19]),
                 label = unique(htwt_double$Team)[19]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[20]),
                 label = unique(htwt_double$Team)[20]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[21]),
                 label = unique(htwt_double$Team)[21]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[22]),
                 label = unique(htwt_double$Team)[22]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[23]),
                 label = unique(htwt_double$Team)[23]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[24]),
                 label = unique(htwt_double$Team)[24]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[25]),
                 label = unique(htwt_double$Team)[25]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[26]),
                 label = unique(htwt_double$Team)[26]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[27]),
                 label = unique(htwt_double$Team)[27]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[28]),
                 label = unique(htwt_double$Team)[28]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[29]),
                 label = unique(htwt_double$Team)[29]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(htwt_double$Team)[30]),
                 label = unique(htwt_double$Team)[30])
          )
        )
      )
    )
p
