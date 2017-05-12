surveyDF <- read.csv("Startsurvey.csv")

bijdrage <- as.character(surveyDF[,7])
bijdrage <- unlist(strsplit(bijdrage, "\\n"))
bijdrageDF <- data.frame(Bijdrage = bijdrage)

ggplot(bijdrageDF, aes(x = Bijdrage, fill=Bijdrage)) +
  geom_bar() +
  theme(legend.title=element_blank(), axis.title.x=element_blank(), axis.text.x=element_blank())
