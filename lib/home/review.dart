import 'package:activerecaller/home/capture.dart';
import 'package:activerecaller/home/card_details/card_details.dart';
import 'package:activerecaller/home/main_screen.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/knowledge_card.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/ui/reusable/db_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';

class ReviewWidget extends StatefulWidget {
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends DbWidgetState<ReviewWidget> {
  List<KnowledgeCard> _cardsFromUser;
  User _user;
  List<KnowledgeCard> _filteredCards = new List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> initStateAsync(AppDatabase database) async {
    _user = await database.userDao.findCurrentUser();
    _cardsFromUser =
        await database.knowledgeCardDao.findAllCardsByUserId(_user.id);
    _filteredCards = _cardsFromUser;
  }

  @override
  Widget buildLoaded(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdbe2ef),
      body: _cardsFromUser.isNotEmpty
          ? Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff112d4e),
                              letterSpacing: 2),),
                      onChanged: (string) {
                        setState(() {
                          _filteredCards = _cardsFromUser
                              .where((element) => element.tags
                                  .toLowerCase()
                                  .contains(string.toLowerCase()))
                              .toList();
                        });
                      }),
                ),
                Flexible(
                  child: KnowledgeCardUI(
                    cardsFromUser: _filteredCards,
                  ),
                ),
              ],
            )
          : EmptyHomeUI(),
    );
  }
}

class KnowledgeCardUI extends StatelessWidget {
  final List<KnowledgeCard> cardsFromUser;
  final TextEditingController editingController;

  const KnowledgeCardUI(
      {Key key, @required this.cardsFromUser, this.editingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cardsFromUser.length,
        itemBuilder: (context, index) {
          final item = cardsFromUser[index];
          return Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    item.title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                ),
                ListTile(
                  title: Text(item.quote),
                ),
                ListTile(
                  title: Text(item.author),
                ),
                Divider(
                  color: Color(0xff112d4e),
                  thickness: 1,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var tag in item.tags.split(","))
                              FittedBox(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: GFButton(
                                    color: Color(0xff3f72af),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CardDetailsWidget(
                                                    knowledgeCardId: item.id,
                                                  )));
                                    },
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
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                      width: 30,
                      child: GFButton(
                        color: Color(0xff3f72af),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        text: "...",
                        padding: EdgeInsets.all(0),
                        shape: GFButtonShape.pills,
                        type: GFButtonType.solid,
                        size: GFSize.SMALL,
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CardDetailsWidget(
                                        knowledgeCardId: item.id,
                                      )));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

class EmptyHomeUI extends StatelessWidget {
  const EmptyHomeUI({
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
          Text("Start by adding some cards!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Capture Knowledge!",
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
                              builder: (context) => MainScreenWidget(
                                    index: 0,
                                  )));
                    },
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
