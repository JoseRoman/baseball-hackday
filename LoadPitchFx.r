library(RMySQL)
con <- dbConnect(MySQL(),
                 user="bbos", password="bbos", dbname="gameday", host="localhost")

rs <- dbSendQuery(con, "select * from pitches")
pitches <- fetch(rs,n=-1)
huh <- dbHasCompleted(rs)

rs <- dbSendQuery(con, "select * from atbats")
atbats = fetch(rs, n=-1)