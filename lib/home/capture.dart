import 'package:activerecaller/home/main_screen.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/knowledge_card.dart';
import 'package:activerecaller/persistance/db/question.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/ui/reusable/db_widget_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class CaptureWidget extends StatefulWidget {
  @override
  _CaptureWidgetState createState() => _CaptureWidgetState();
}

class _CaptureWidgetState extends DbWidgetState<CaptureWidget> {
  User _user;
  bool _autoValidate = false;
  final titleTextController = TextEditingController();
  final quoteTextController = TextEditingController();
  final mediaNameTextController = TextEditingController();
  final authorTextController = TextEditingController();
  final tagsTextController = TextEditingController();
  final personalNoteTextController = TextEditingController();
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final defaultFontStyle = TextStyle(
      fontWeight: FontWeight.w500, color: Color(0xff112d4e), letterSpacing: 2);

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
  }

  @override
  Widget buildLoaded(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdbe2ef),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
                  controller: personalNoteTextController,
                  decoration: InputDecoration(
                      labelText: "Personal Note", labelStyle: defaultFontStyle),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: GFButton(
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
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      var db = DB.instance.database;

                      KnowledgeCard knowledgeCard = KnowledgeCard.createNew(
                          titleTextController.value.text,
                          quoteTextController.value.text,
                          mediaNameTextController.value.text,
                          authorTextController.value.text,
                          tagsTextController.value.text,
                          personalNoteTextController.value.text,
                          _user.id);

                      Question question = Question.createNew(
                          questionTextController.value.text,
                          answerTextController.value.text,
                          DateTime.now().toIso8601String(),
                          knowledgeCard.id);

                      var cardId =
                          await db.knowledgeCardDao.insertCard(knowledgeCard);
                      var questionId =
                          await db.questionDao.insertQuestion(question);

                      knowledgeCard.id = cardId;
                      knowledgeCard.questionId = questionId;

                      question.id = questionId;
                      question.cardId = cardId;

                      db.knowledgeCardDao.updateCard(knowledgeCard);
                      db.questionDao.updateQuestion(question);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreenWidget()));
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
