import 'dart:async';
import 'package:activerecaller/persistance/db/knowledge_card.dart';
import 'package:activerecaller/persistance/db/card_game.dart';
import 'package:activerecaller/persistance/db/integration_game.dart';
import 'package:activerecaller/persistance/db/question.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/persistance/dto/card_dao.dart';
import 'package:activerecaller/persistance/dto/card_game_dao.dart';
import 'package:activerecaller/persistance/dto/integration_game_dao.dart';
import 'package:activerecaller/persistance/dto/question_dao.dart';
import 'package:activerecaller/persistance/dto/user_dao.dart';
import 'package:activerecaller/theme/light_colors.dart';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:flutter_spinkit/flutter_spinkit.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  KnowledgeCard,
  CardGame,
  IntegrationGame,
  Question,
  User,
])
abstract class AppDatabase extends FloorDatabase {
  KnowledgeCardDao get knowledgeCardDao;

  CardGameDao get cardGameDao;

  IntegrationGameDao get integrationGameDao;

  QuestionDao get questionDao;

  UserDao get userDao;
}

class DB {
  AppDatabase database;

  static Widget loading() {
    return SpinKitThreeBounce(color: LightColors.kDarkBlue);
  }

  Future<AppDatabase> getDatabase() async {
    if (database == null) {
      database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    }
    return database;
  }

  static KnowledgeCardDao get cardDto => _instance.database.knowledgeCardDao;

  static CardGameDao get cardGameDto => _instance.database.cardGameDao;

  static IntegrationGameDao get integrationGameDto =>
      _instance.database.integrationGameDao;

  static QuestionDao get questionDto => _instance.database.questionDao;

  static UserDao get userDto => _instance.database.userDao;

  static final DB _instance = DB();

  static DB get instance => _instance;
}
