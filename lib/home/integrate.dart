import 'package:activerecaller/home/game/game.dart';
import 'package:activerecaller/home/main_screen.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/integration_game.dart';
import 'package:activerecaller/persistance/db/knowledge_card.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/ui/reusable/db_widget_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'capture.dart';

class IntegrateWidget extends StatefulWidget {
  @override
  _IntegrateWidgetState createState() => _IntegrateWidgetState();
}

class _IntegrateWidgetState extends DbWidgetState<IntegrateWidget> {
  User _user;
  List<IntegrationGame> _gamesFromUser;
  List<KnowledgeCard> _knowledgeCards;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> initStateAsync(AppDatabase database) async {
    _user = await database.userDao.findCurrentUser();
    _gamesFromUser = await database.integrationGameDao
        .findAllIntegrationGamesByUserId(_user.id);
    _knowledgeCards =
        await database.knowledgeCardDao.findAllCardsByUserId(_user.id);
    _gamesFromUser.sort((a, b) => b.score.compareTo(a.score));
  }

  @override
  Widget buildLoaded(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdbe2ef),
      body: _gamesFromUser.isNotEmpty
          ? HighScoreUI(
              gamesFromUser: _gamesFromUser.sublist(
                  0, _gamesFromUser.length < 5 ? _gamesFromUser.length : 5),
            )
          : EmptyHighScoreUI(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          //UNCOMMENT THIS CONTAINER TO CLEAN YOUR SCORES
//          Container(
//            height: 100.0,
//            width: 100.0,
//            child: FloatingActionButton(
//              child: Text(
//                "Delete Games",
//                textAlign: TextAlign.center,
//                style: TextStyle(fontSize: 25),
//              ),
//              onPressed: () async {
//                var db = DB.instance.database;
//                for (var game in _gamesFromUser)
//                  await db.integrationGameDao
//                      .deleteIntegrationGame(game);
//              },
//            ),
//          ),
          Container(
            height: 100.0,
            width: 100.0,
            child: FloatingActionButton(
              child: Text(
                "New Game",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                if (_knowledgeCards.length != 0) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameWidget()));
                } else {
                  _popupDialog(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("You haven't captured any knowledge yet!"),
            content: Text('Please, start by capturing knowledge!'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreenWidget(index: 0)),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Capture some knowledge!',
                  )),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Dismiss')),
            ],
          );
        });
  }
}

class HighScoreUI extends StatelessWidget {
  final List<IntegrationGame> gamesFromUser;

  const HighScoreUI({Key key, @required this.gamesFromUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: gamesFromUser.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                      height: 250,
                      width: 250,
                      child: Image.asset(
                          'assets/images/ActiveRecaller_whiteBg.png')),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Highscores",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          }
          index -= 1;
          var item = gamesFromUser[index];
          return Container(
              margin: EdgeInsets.fromLTRB(90, 0, 90, 0),
              height: 50,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(item.dateTime.substring(0, 10),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1)),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(item.score.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300)),
                  )
                ],
              ));
        });
  }
}

class EmptyHighScoreUI extends StatelessWidget {
  const EmptyHighScoreUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 50),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 50),
            child: Image.asset('assets/images/ActiveRecaller_whiteBg.png'),
          ),
          Text("No games here, yet!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Start your first game!!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GameWidget()));
                    },
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
