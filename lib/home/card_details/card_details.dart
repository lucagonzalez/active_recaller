import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/knowledge_card.dart';
import 'package:activerecaller/persistance/db/question.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/ui/reusable/db_widget_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_button_type.dart';

import '../main_screen.dart';

class CardDetailsWidget extends StatefulWidget {
  final int knowledgeCardId;

  const CardDetailsWidget({Key key, this.knowledgeCardId}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _CardDetailsWidget(this.knowledgeCardId);
}

class _CardDetailsWidget extends DbWidgetState<CardDetailsWidget> {
  User _user;
  KnowledgeCard _knowledgeCard;
  Question _question;
  final int knowledgeCardId;
  final titleTextController = TextEditingController();
  final quoteTextController = TextEditingController();
  final mediaNameTextController = TextEditingController();
  final authorTextController = TextEditingController();
  final tagsTextController = TextEditingController();
  final personalNoteTextController = TextEditingController();
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final defaultFontStyle = TextStyle(
      fontWeight: FontWeight.w500, color: Color(0xff112d4e), letterSpacing: 2);

  _CardDetailsWidget(this.knowledgeCardId);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleTextController.dispose();
    quoteTextController.dispose();
    mediaNameTextController.dispose();
    authorTextController.dispose();
    tagsTextController.dispose();
    personalNoteTextController.dispose();
    questionTextController.dispose();
    answerTextController.dispose();
    super.dispose();
  }

  @override
  Future<void> initStateAsync(AppDatabase database) async {
    _user = await database.userDao.findCurrentUser();
    _knowledgeCard =
        await database.knowledgeCardDao.findCardById(knowledgeCardId);
    _question =
        await database.questionDao.findQuestionByCardId(knowledgeCardId);
    titleTextController.text = _knowledgeCard.title;
    quoteTextController.text = _knowledgeCard.quote;
    mediaNameTextController.text = _knowledgeCard.mediaName;
    authorTextController.text = _knowledgeCard.author;
    tagsTextController.text = _knowledgeCard.tags;
    personalNoteTextController.text = _knowledgeCard.personalNote;
    questionTextController.text = _question.title;
    answerTextController.text = _question.answer;
  }

  @override
  Widget buildLoaded(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdbe2ef),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: double.maxFinite,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                color: Color(0xfff9f7f7)),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    titleTextController.text,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                ),
                ListTile(
                  title: Text(quoteTextController.text),
                ),
                ListTile(
                  title: Text(authorTextController.text),
                ),
                ListTile(
                  title: Text(mediaNameTextController.text),
                ),
                Divider(
                  color: Color(0xff112d4e),
                  thickness: 1,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      for (var tag in tagsTextController.text.split(","))
                        FittedBox(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: GFButton(
                              onPressed: () {
                                print("FUCK");
                              },
                              color: Color(0xff3f72af),
                              text: tag,
                              shape: GFButtonShape.pills,
                              type: GFButtonType.outline,
                              size: GFSize.SMALL,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xff112d4e),
                  thickness: 1,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("Personal Note: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)))),
                ListTile(
                  title: Text(personalNoteTextController.text),
                ),
                Divider(
                  color: Color(0xff112d4e),
                  thickness: 1,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("Question: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)))),
                ListTile(
                  title: Text(questionTextController.text),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("Answer: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)))),
                ListTile(
                  title: Text(answerTextController.text),
                ),
                Divider(
                  color: Color(0xff112d4e),
                  thickness: 1,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text("Last Played: " +
                          _question.lastAnswered.substring(0, 10))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 40,
                        onPressed: () async {
                          _editDialog(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_forever),
                        iconSize: 40,
                        onPressed: () async {
                          _popupDialog(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: titleTextController,
                      decoration: InputDecoration(
                          labelText: "Title", labelStyle: defaultFontStyle),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: quoteTextController,
                      decoration: InputDecoration(
                          labelText: "Quote", labelStyle: defaultFontStyle),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: mediaNameTextController,
                      decoration: InputDecoration(
                          labelText: "Media", labelStyle: defaultFontStyle),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: authorTextController,
                      decoration: InputDecoration(
                          labelText: "Author", labelStyle: defaultFontStyle),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: tagsTextController,
                      decoration: InputDecoration(
                          labelText: "Tags", labelStyle: defaultFontStyle),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.trim().split(",").indexOf(" ") != -1) {
                          return 'Insert tags separated by commas';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: personalNoteTextController,
                      decoration: InputDecoration(
                          labelText: "Personal Note",
                          labelStyle: defaultFontStyle),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: questionTextController,
                      decoration: InputDecoration(
                          labelText: "Question", labelStyle: defaultFontStyle),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: answerTextController,
                      decoration: InputDecoration(
                          labelText: "Answer", labelStyle: defaultFontStyle),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              GFButton(
                shape: GFButtonShape.pills,
                blockButton: true,
                color: Color(0xff3f72af),
                type: GFButtonType.outline,
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      letterSpacing: 3),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var db = DB.instance.database;
                    setState(() {
                      _knowledgeCard.title = titleTextController.text;
                      _knowledgeCard.quote = quoteTextController.text;
                      _knowledgeCard.mediaName = mediaNameTextController.text;
                      _knowledgeCard.author = authorTextController.text;
                      _knowledgeCard.tags = tagsTextController.text;
                      _knowledgeCard.personalNote =
                          personalNoteTextController.text;
                      _question.title = questionTextController.text;
                      _question.answer = answerTextController.text;
                    });
                    await db.knowledgeCardDao.updateCard(_knowledgeCard);
                    await db.questionDao
                        .updateQuestion(_question)
                        .then((value) => Navigator.of(context).pop());
                  }
                },
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure about this?'),
            content: Text('This card will be gone forever!'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    var db = DB.instance.database;
                    await db.knowledgeCardDao.deleteCard(_knowledgeCard);
                    await db.questionDao.deleteQuestion(_question);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreenWidget()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  color: Colors.red,
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.black),
                  )),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL')),
            ],
          );
        });
  }
}
