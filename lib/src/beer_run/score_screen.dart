part of beer_run;

class ScoreScreen extends View {

  int _score;
  int _convertedScore;
  Duration _timeAllowed;
  Duration _timeRemaining;

  DivElement get rootElement => null;

  ScoreScreen(this._score, this._convertedScore,
      this._timeAllowed, this._timeRemaining) :
    super();

  void onDraw(Element root) {

    DivElement el = new DivElement();
    el.style.lineHeight = "24px";

    DivElement beersEl = new DivElement();
    beersEl.style.marginLeft = "auto";
    beersEl.style.marginRight = "auto";
    beersEl.style.width = "50%";

    ImageElement beersIcon = new ImageElement();
    beersIcon.src = "img/beer.png";
    beersIcon.style.float = "left";
    beersIcon.style.margin = "5px";
    beersIcon.width = 48;
    beersIcon.height = 48;
    beersEl.append(beersIcon);

    DivElement beersTextEl = new DivElement();
    beersTextEl.text = "${this._score} beers delivered";
    beersTextEl.style.fontWeight = "bold";
    beersTextEl.style.fontSize = "22px";
    beersTextEl.style.height = "58px";
    beersEl.append(beersTextEl);

    DivElement beersClearEl = new DivElement();
    beersClearEl.style.clear = "both";
    beersEl.append(beersClearEl);

    el.append(beersEl);

    DivElement timeEl = new DivElement();
    timeEl.style.marginLeft = "auto";
    timeEl.style.marginRight = "auto";
    timeEl.style.width = "50%";

    ImageElement clockIcon = new ImageElement();
    clockIcon.src = "img/clock.png";
    clockIcon.style.float = "left";
    clockIcon.style.margin = "5px";
    clockIcon.width = 48;
    clockIcon.height = 48;
    timeEl.append(clockIcon);

    DivElement timeTextEl = new DivElement();
    int s1 = this._timeAllowed.inSeconds;
    int s2 = this._timeRemaining.inSeconds;
    int s3 = s1 - s2;
    Duration timeTook = new Duration(seconds: s3);
    int minutes = timeTook.inMinutes;
    String formattedTime = "${minutes}:";
    int seconds = timeTook.inSeconds % 60;
    if (seconds < 10) {
      formattedTime = "${formattedTime}0${seconds}";
    } else {
      formattedTime = "${formattedTime}${seconds}";
    }
    timeTextEl.text = "You took ${formattedTime}!";
    timeTextEl.style.fontWeight = "bold";
    timeTextEl.style.fontSize = "22px";
    timeTextEl.style.height = "58px";
    timeEl.append(timeTextEl);

    DivElement timeClearEl = new DivElement();
    timeClearEl.style.clear = "both";
    timeEl.append(timeClearEl);

    el.append(timeEl);

    DivElement scoreEl = new DivElement();
    scoreEl.style.marginLeft = "auto";
    scoreEl.style.marginRight = "auto";
    scoreEl.style.width = "256px";
    scoreEl.style.background = "#5482a9";
    scoreEl.style.padding = "12px";
    scoreEl.style.borderRadius = "8px";
    scoreEl.style.height = "24px";

    DivElement scoreTextEl = new DivElement();
    scoreTextEl.text = "Your Score: ${this._convertedScore}";
    scoreTextEl.style.fontWeight = "bold";
    scoreTextEl.style.fontSize = "22px";
    scoreTextEl.style.height = "58px";
    scoreTextEl.style.marginLeft = "auto";
    scoreTextEl.style.marginRight = "auto";
    scoreEl.append(scoreTextEl);

    el.append(scoreEl);

    el.classes = ["ui", "text"];
    root.append(
      el
    );
  }
}

