//You thiught this was a normal time handler, but it was me, Dio! ZAWARUDO!!!
zeTime = gameDuration - gameTimer;

timeString = "";
minutes = floor(zeTime/3600);
seconds = floor(zeTime/60 - minutes*60);
miliseconds = floor((zeTime/60*1000 - (minutes*60*1000 + seconds*1000))/10);

if (minutes < 10) {
    timeString += "0";
    timeString += string(minutes);
} else {
    timeString += string(minutes);
}
timeString += ":";
if (seconds < 10) {
    timeString += "0";
    timeString += string(seconds);
} else {
    timeString += string(seconds);
}
timeString += ":";
if (miliseconds < 10) {
    timeString += "0";
    timeString += string(miliseconds);
} else {
    timeString += string(miliseconds);
}

draw_set_font(fMenu);
if (GameController.inGame) {
    draw_text(20, ScoreManager.GUI_y, timeString);    
}

