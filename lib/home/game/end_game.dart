
import 'package:activerecaller/home/game/game.dart';
import 'package:activerecaller/home/main_screen.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/integration_game.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/ui/reusable/db_widget_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';

class EndGameWidget extends StatefulWidget {
  final IntegrationGame game;

  const EndGameWidget({Key key, this.game}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EndGameWidget(this.game);
}

class _EndGameWidget extends DbWidgetState<EndGameWidget> {
  User _user;
  final IntegrationGame _game;
  List<IntegrationGame> _gamesFromUser;
  int _lastGameScore;
  IntegrationGame _highScoreGame;

  _EndGameWidget(this._game);

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> initStateAsync(AppDatabase database) async {
    _user = await database.userDao.findCurrentUser();
    _gamesFromUser = await database.integrationGameDao
        .findAllIntegrationGamesByUserId(_user.id);
    _gamesFromUser.sort((a, b) => b.score.compareTo(a.score));
    _highScoreGame = _gamesFromUser[0];
    _gamesFromUser.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    _lastGameScore = _gamesFromUser.length > 1 ? _gamesFromUser[1].score : -1;
  }

  @override
  Widget buildLoaded(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 10),
            child: Image.asset('assets/images/ActiveRecaller_whiteBg.png'),
          ),
          Text("CONGRATULATIONS!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
            child: Text(
              "You got " + _game.score.toString() + " questions right!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _lastGameScore > _game.score
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.cancel),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.check_circle),
                      ),
                _lastGameScore > _game.score
                    ? Text(
                        (_lastGameScore - _game.score).toString() +
                            " less points than the last game",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : _lastGameScore == _game.score
                        ? Text(
                            "You tied your last game!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : _lastGameScore == -1
                            ? Text(
                                "Not bad for your first game",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Text(
                                (_game.score - _lastGameScore).toString() +
                                    " more points than the last game",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _highScoreGame.score > _game.score
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.cancel),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.check_circle),
                      ),
                _highScoreGame.score > _game.score
                    ? Text(
                        (_highScoreGame.score - _game.score).toString() +
                            " less points than your high score",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : _highScoreGame.score == _game.score
                        ? Text(
                            "You tied your high score!!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            (_game.score - _highScoreGame.score).toString() +
                                " more points than you high score!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GFButton(
                  shape: GFButtonShape.pills,
                  color: Color(0xff3f72af),
                  size: GFSize.LARGE,
                  type: GFButtonType.solid,
                  child: Text("Play again"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreenWidget(index: 2)),
                        (route) => false);
                  },
                ),
                GFButton(
                  shape: GFButtonShape.pills,
                  size: GFSize.LARGE,
                  color: Color(0xff3f72af),
                  type: GFButtonType.solid,
                  child: Text("Go Home"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreenWidget(index: 1)),
                        (route) => false);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
