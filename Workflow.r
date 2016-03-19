library(RMySQL)
con <- dbConnect(MySQL(),
                 user="bbos", password="bbos", dbname="gameday", host="localhost")

rs <- dbSendQuery(con, "select * from pitches")
pitches <- fetch(rs,n=-1)
huh <- dbHasCompleted(rs)

rs <- dbSendQuery(con, "select * from atbats")
atbats = fetch(rs, n=-1)

atbats$groundOut = groundOut(atbats$event)


lastPitch = aggregate(pitches$id, by =list(pitches$gameName, pitches$gameAtBatID), FUN=max)
names(lastPitch) = c("gameName", "gameAtBatID", "maxPitch")
pitchesWithLastPitch = merge(pitches, lastPitch)
onlyLastPitches = subset(pitchesWithLastPitch, pitchesWithLastPitch$id == pitchesWithLastPitch$maxPitch)

atbats$eventNumber = as.numeric(atbats$eventNumber)

atbatResults = merge(atbats, onlyLastPitches, by.x=c("gameName", "eventNumber"), by.y = c("gameName", "gameAtBatID"))
atbatResults$year =  as.numeric(substr(atbatResults$gameName, 5, 8))

atbatResults$count = 1

atbatResults$atBat = atBat(atbatResults)
atbatResults$plateAppearance = plateAppearance(atbatResults)
atbatResults$totalBases = totalBases(atbatResults)
atbatResults$hit = hit(atbatResults)
atbatResults$onBase = onBase(atbatResults)
atbatResults$wOba = wOba(atbatResults)

isPa = subset(atbatResults, atbatResults$plateAppearance == 1)
isAb = subset(atbatResults, atbatResults$atBat == 1)

countResults = avgResults = aggregate(isPa$count, by=list(isPa$batter, isPa$year, isPa$pitch_type), FUN=sum)
avgResults = aggregate(isAb$hit, by=list(isAb$batter, isAb$year, isAb$pitch_type), FUN=mean)
slgResults = aggregate(isAb$totalBases, by=list(isAb$batter, isAb$year, isAb$pitch_type), FUN=mean)
obaResults = aggregate(isPa$onBase, by=list(isPa$batter, isPa$year, isPa$pitch_type), FUN=mean)
wObaResults = aggregate(isPa$wOba, by=list(isPa$batter, isPa$year, isPa$pitch_type), FUN=mean)

names(countResults) = c("BatterID", "Year", "PitchType", "count")
names(avgResults) = c("BatterID", "Year", "PitchType", "AVG")
names(slgResults) = c("BatterID", "Year", "PitchType", "SLG")
names(obaResults) = c("BatterID", "Year", "PitchType", "OBP")
names(wObaResults) = c("BatterID", "Year", "PitchType", "wOBA")

combinedResults = merge(merge(countResults, obaResults), wObaResults)

dbWriteTable(con, value = combinedResults, name = "Results", append = TRUE ) 



#atbatResults = merge(atbats, onlyLastPitches, by.x=list(atbats$gameName, atbats$eventNumber), by.y = list(onlyLastPitches$gameName, onlyLastPitches$gameAtBatID))
#pitchesWithOnlyLastPitch = merge(pitches, onlyLastPitches)
