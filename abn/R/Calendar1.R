library(googleVis)
summUsersPerDateTot <- read.csv("R/summUsersPerDateTot.csv", stringsAsFactors = FALSE)
summUsersPerDateTot$date <- as.Date(summUsersPerDateTot$date)
Cal <- gvisCalendar(summUsersPerDateTot, 
                    datevar="date", 
                    numvar="Hits",
                    options=list(
                      title="Gebruikers per dag",
                      width=1400,
                      height=600,
                      calendar="{yearLabel: { fontName: 'Arial',
                      fontSize: 36, color: 'skyblue', bold: true},
                      cellSize: 20,
                      cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                      focusedCellColor: {stroke:'red'}}")
                    )
plot(Cal)