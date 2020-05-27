import 'dart:async';

import 'package:activerecaller/home/game/components/countdown.dart';
import 'package:activerecaller/home/game/end_game.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/integration_game.dart';
import 'package:activerecaller/persistance/db/knowledge_card.dart';
import 'package:activerecaller/persistance/db/question.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/ui/reusable/db_widget_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends DbWidgetState<GameWidget> {
  User _user;
  List<KnowledgeCard> knowledgeCards;
  int _points;
  List<Question> _questions = new List();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _addPoint() {
    _points += 1;
  }

  @override
  Future<void> initStateAsync(AppDatabase database) async {
    _user = await database.userDao.findCurrentUser();
    knowledgeCards =
        await database.knowledgeCardDao.findAllCardsByUserId(_user.id);
    for (var card in knowledgeCards) {
      var question = await database.questionDao.findQuestionByCardId(card.id);
      _questions.add(question);
    }
    _questions.sort((a, b) => b.lastAnswered.compareTo(a.lastAnswered));
    _points = 0;
  }

  @override
  Widget buildLoaded(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdbe2ef),
      resizeToAvoidBottomPadding: true,
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Wrap(
                children: [
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(top: 30),
                    child: CountDownTimer(
                      onTimeFinished: () async {
                        await saveGameAndRedirect(context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            for (var i = 0; i < _questions.length; i++)
                              Card(
                                margin: EdgeInsets.fromLTRB(30, 30, 30, 200),
                                color: Colors.white,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          _questions[i].title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () async {
                                              setState(() {
                                                _questions.removeAt(i);
                                                myController.clear();
                                              });
                                              if (_questions.length == 0) {
                                                await saveGameAndRedirect(
                                                    context);
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.check_circle),
                                            onPressed: () async {
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);
                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                              if (_questions[i]
                                                      .answer
                                                      .toLowerCase()
                                                      .trim() ==
                                                  myController.text
                                                      .toLowerCase()
                                                      .trim()) {
                                                _addPoint();
                                                myController.clear();
                                              }
                                              setState(() {
                                                _questions.removeAt(i);
                                              });
                                              if (_questions.length == 0) {
                                                await saveGameAndRedirect(
                                                    context);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      TextField(
                                        controller: myController,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future saveGameAndRedirect(BuildContext context) async {
    var db = DB.instance.database;
    IntegrationGame game =
        IntegrationGame.createNew(_points, DateTime.now().toString(), _user.id);
    for(var q in _questions){
      q.lastAnswered = DateTime.now().toString();
      db.questionDao.updateQuestion(q);
    }
    db.integrationGameDao.insertIntegrationGame(game);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EndGameWidget(
                  game: game,
                )));
  }
}
