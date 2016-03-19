groundOut = function(table){
  ifelse(table$event == "Groundout", 1, 0)
}

strikeout = function(table){
  ifelse(table$event == "Strikeout", 1, 0)
} 

flyout = function(table){
  ifelse(table$event == "Flyout", 1, 0)
} 

lineout = function(table){
  ifelse(table$event == "Lineout", 1, 0)
} 

single = function(table){
  ifelse(table$event == "Single", 1, 0)
} 

groundedIntoDP = function(table){
  ifelse(table$event == "Grounded Into DP", 1, 0)
} 

batterInterference = function(table){
  ifelse(table$event == "Batter Interference", 1, 0)
} 

popOut = function(table){
  ifelse(table$event == "Pop Out", 1, 0)
} 

walk = function(table){
  ifelse(table$event == "Walk", 1, 0)
} 

forceOut = function(table){
  ifelse(table$event == "Forceout", 1, 0)
} 

homeRun = function(table){
  ifelse(table$event == "Home Run", 1, 0)
} 

fieldError = function(table){
  ifelse(table$event == "Field Error", 1, 0)
} 

buntGroundout = function(table){
  ifelse(table$event == "Bunt Groundout", 1, 0)
} 

sacBunt = function(table){
  ifelse(table$event == "Sac Bunt", 1, 0)
} 

sacFly = function(table){
  ifelse(table$event == "Sac Fly", 1, 0)
} 

double = function(table){
  ifelse(table$event == "Double", 1, 0)
} 

hitByPitch = function(table){
  ifelse(table$event == "Hit By Pitch", 1, 0)
} 

runnerOut = function(table){
  ifelse(table$event == "Runner Out", 1, 0)
} 

triple = function(table){
  ifelse(table$event == "Triple", 1, 0)
} 

doublePlay = function(table){
  ifelse(table$event == "Double Play", 1, 0)
} 

fieldersChoice = function(table){
  ifelse(table$event == "Fielders Choice", 1, 0)
} 

intentWalk = function(table){
  ifelse(table$event == "Intent Walk", 1, 0)
} 

fieldersChoiceOut = function(table){
  ifelse(table$event == "Fielders Choice Out", 1, 0)
} 

strikeoutDP = function(table){
  ifelse(table$event == "Strikeout - DP", 1, 0)
} 

buntPopOut = function(table){
  ifelse(table$event == "Bunt Pop Out", 1, 0)
} 

catcherInterference = function(table){
  ifelse(table$event == "Catcher Interference", 1, 0)
} 

fieldersChoiceOut = function(table){
  ifelse(table$event == "Fielders Choice Out", 1, 0)
} 

fanInterference = function(table){
  ifelse(table$event == "Fan interference", 1, 0)
} 

buntLineout = function(table){
  ifelse(table$event == "Bunt Lineout", 1, 0)
} 

sacFlyDP = function(table){
  ifelse(table$event == "Sac Fly DP", 1, 0)
} 

triplePlay = function(table){
  ifelse(table$event == "Triple Play", 1, 0)
} 

sacrificeBuntDP = function(table){
  ifelse(table$event == "Sacrifice Bunt DP", 1, 0)
} 

atBat = function(table){
  groundOut(table) +
    strikeout(table) +
    flyout(table) +
    single(table) +
    groundedIntoDP(table) +
    batterInterference(table) +
    popOut(table) +
    forceOut(table) +
    homeRun(table) +
    fieldError(table) +
    buntGroundout(table) +
    double(table) +
    triple(table) +
    doublePlay(table) +
    fieldersChoice(table) +
    fieldersChoiceOut(table) +
    strikeoutDP(table) +
    buntPopOut(table) +
    catcherInterference(table) +
    fanInterference(table) +
    buntLineout(table) +
    sacFlyDP(table) +
    triplePlay(table) +
    sacrificeBuntDP(table)
}

plateAppearance = function(table){
  atBat(table) + walk(table) +
    sacBunt(table) +
    sacFly(table) +
    hitByPitch(table) +
    intentWalk(table)
}

totalBases = function(table){
  single(table) + 2*double(table) + 3*triple(table) + 4*homeRun(table)
}

hit = function (table) {
  single(table) + double(table) + triple(table) + homeRun(table)
}

onBase = function (table) {
  single(table) + double(table) + triple(table) + homeRun(table) + hitByPitch(table) +
    intentWalk(table) + walk(table)
}

wOba= function(table){
  .72 * walk(table) + .75*hitByPitch(table) + .9*single(table) +
    .92 * fieldError(table) + 1.24 * double(table) + 1.56 * triple(table) +
    1.95 * homeRun(table)
}


