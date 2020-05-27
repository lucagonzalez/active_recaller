// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  KnowledgeCardDao _knowledgeCardDaoInstance;

  CardGameDao _cardGameDaoInstance;

  IntegrationGameDao _integrationGameDaoInstance;

  QuestionDao _questionDaoInstance;

  UserDao _userDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `knowledge_card` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `quote` TEXT, `mediaName` TEXT, `author` TEXT, `tags` TEXT, `personalNote` TEXT, `question_id` INTEGER, `user_id` INTEGER, FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `card_game` (`card_id` INTEGER, `integration_game_id` INTEGER, `dateTime` TEXT, FOREIGN KEY (`card_id`) REFERENCES `knowledge_card` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`integration_game_id`) REFERENCES `integration_game` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`card_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `integration_game` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `score` INTEGER, `dateTime` TEXT, `user_id` INTEGER, FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `question` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `answer` TEXT, `lastAnswered` TEXT, `card_id` INTEGER, FOREIGN KEY (`card_id`) REFERENCES `knowledge_card` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `lastName` TEXT, `email` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  KnowledgeCardDao get knowledgeCardDao {
    return _knowledgeCardDaoInstance ??=
        _$KnowledgeCardDao(database, changeListener);
  }

  @override
  CardGameDao get cardGameDao {
    return _cardGameDaoInstance ??= _$CardGameDao(database, changeListener);
  }

  @override
  IntegrationGameDao get integrationGameDao {
    return _integrationGameDaoInstance ??=
        _$IntegrationGameDao(database, changeListener);
  }

  @override
  QuestionDao get questionDao {
    return _questionDaoInstance ??= _$QuestionDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$KnowledgeCardDao extends KnowledgeCardDao {
  _$KnowledgeCardDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _knowledgeCardInsertionAdapter = InsertionAdapter(
            database,
            'knowledge_card',
            (KnowledgeCard item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'quote': item.quote,
                  'mediaName': item.mediaName,
                  'author': item.author,
                  'tags': item.tags,
                  'personalNote': item.personalNote,
                  'question_id': item.questionId,
                  'user_id': item.userId
                }),
        _knowledgeCardUpdateAdapter = UpdateAdapter(
            database,
            'knowledge_card',
            ['id'],
            (KnowledgeCard item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'quote': item.quote,
                  'mediaName': item.mediaName,
                  'author': item.author,
                  'tags': item.tags,
                  'personalNote': item.personalNote,
                  'question_id': item.questionId,
                  'user_id': item.userId
                }),
        _knowledgeCardDeletionAdapter = DeletionAdapter(
            database,
            'knowledge_card',
            ['id'],
            (KnowledgeCard item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'quote': item.quote,
                  'mediaName': item.mediaName,
                  'author': item.author,
                  'tags': item.tags,
                  'personalNote': item.personalNote,
                  'question_id': item.questionId,
                  'user_id': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _knowledge_cardMapper = (Map<String, dynamic> row) =>
      KnowledgeCard(
          row['id'] as int,
          row['title'] as String,
          row['quote'] as String,
          row['mediaName'] as String,
          row['author'] as String,
          row['tags'] as String,
          row['personalNote'] as String,
          row['question_id'] as int,
          row['user_id'] as int);

  final InsertionAdapter<KnowledgeCard> _knowledgeCardInsertionAdapter;

  final UpdateAdapter<KnowledgeCard> _knowledgeCardUpdateAdapter;

  final DeletionAdapter<KnowledgeCard> _knowledgeCardDeletionAdapter;

  @override
  Future<List<KnowledgeCard>> findAllCardsByUserId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM knowledge_card WHERE user_id = ?',
        arguments: <dynamic>[id],
        mapper: _knowledge_cardMapper);
  }

  @override
  Future<KnowledgeCard> findCardById(int id) async {
    return _queryAdapter.query('SELECT * FROM knowledge_card WHERE id = ?',
        arguments: <dynamic>[id], mapper: _knowledge_cardMapper);
  }

  @override
  Future<KnowledgeCard> findCardByQuestionId(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM knowledge_card WHERE question_id = ?',
        arguments: <dynamic>[id],
        mapper: _knowledge_cardMapper);
  }

  @override
  Future<int> insertCard(KnowledgeCard card) {
    return _knowledgeCardInsertionAdapter.insertAndReturnId(
        card, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateCard(KnowledgeCard card) {
    return _knowledgeCardUpdateAdapter.updateAndReturnChangedRows(
        card, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteCard(KnowledgeCard card) {
    return _knowledgeCardDeletionAdapter.deleteAndReturnChangedRows(card);
  }
}

class _$CardGameDao extends CardGameDao {
  _$CardGameDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _cardGameInsertionAdapter = InsertionAdapter(
            database,
            'card_game',
            (CardGame item) => <String, dynamic>{
                  'card_id': item.cardId,
                  'integration_game_id': item.integrationGameId,
                  'dateTime': item.dateTime
                }),
        _cardGameDeletionAdapter = DeletionAdapter(
            database,
            'card_game',
            ['card_id'],
            (CardGame item) => <String, dynamic>{
                  'card_id': item.cardId,
                  'integration_game_id': item.integrationGameId,
                  'dateTime': item.dateTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _card_gameMapper = (Map<String, dynamic> row) => CardGame(
      row['card_id'] as int,
      row['integration_game_id'] as int,
      row['dateTime'] as String);

  final InsertionAdapter<CardGame> _cardGameInsertionAdapter;

  final DeletionAdapter<CardGame> _cardGameDeletionAdapter;

  @override
  Future<CardGame> findCardGameById(int id) async {
    return _queryAdapter.query('SELECT * FROM card_game WHERE id = ?',
        arguments: <dynamic>[id], mapper: _card_gameMapper);
  }

  @override
  Future<List<CardGame>> findAllCardGamesByCardId(int id) async {
    return _queryAdapter.queryList('SELECT * FROM card_game WHERE card_id = ?',
        arguments: <dynamic>[id], mapper: _card_gameMapper);
  }

  @override
  Future<List<CardGame>> findAllCardGamesByIntegrationGameIdId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM card_game WHERE integration_game_id = ?',
        arguments: <dynamic>[id],
        mapper: _card_gameMapper);
  }

  @override
  Future<int> createCardGame(CardGame cardGame) {
    return _cardGameInsertionAdapter.insertAndReturnId(
        cardGame, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteCardGame(CardGame cardGame) {
    return _cardGameDeletionAdapter.deleteAndReturnChangedRows(cardGame);
  }
}

class _$IntegrationGameDao extends IntegrationGameDao {
  _$IntegrationGameDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _integrationGameInsertionAdapter = InsertionAdapter(
            database,
            'integration_game',
            (IntegrationGame item) => <String, dynamic>{
                  'id': item.id,
                  'score': item.score,
                  'dateTime': item.dateTime,
                  'user_id': item.userId
                }),
        _integrationGameUpdateAdapter = UpdateAdapter(
            database,
            'integration_game',
            ['id'],
            (IntegrationGame item) => <String, dynamic>{
                  'id': item.id,
                  'score': item.score,
                  'dateTime': item.dateTime,
                  'user_id': item.userId
                }),
        _integrationGameDeletionAdapter = DeletionAdapter(
            database,
            'integration_game',
            ['id'],
            (IntegrationGame item) => <String, dynamic>{
                  'id': item.id,
                  'score': item.score,
                  'dateTime': item.dateTime,
                  'user_id': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _integration_gameMapper = (Map<String, dynamic> row) =>
      IntegrationGame(row['id'] as int, row['score'] as int,
          row['dateTime'] as String, row['user_id'] as int);

  final InsertionAdapter<IntegrationGame> _integrationGameInsertionAdapter;

  final UpdateAdapter<IntegrationGame> _integrationGameUpdateAdapter;

  final DeletionAdapter<IntegrationGame> _integrationGameDeletionAdapter;

  @override
  Future<IntegrationGame> findIntegrationGameById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM integration_game WHERE integration_game.id = ?',
        arguments: <dynamic>[id],
        mapper: _integration_gameMapper);
  }

  @override
  Future<List<IntegrationGame>> findAllIntegrationGamesByUserId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM integration_game WHERE integration_game.user_id = ?',
        arguments: <dynamic>[id],
        mapper: _integration_gameMapper);
  }

  @override
  Future<int> insertIntegrationGame(IntegrationGame integrationGame) {
    return _integrationGameInsertionAdapter.insertAndReturnId(
        integrationGame, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateIntegrationGame(IntegrationGame integrationGame) {
    return _integrationGameUpdateAdapter.updateAndReturnChangedRows(
        integrationGame, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteIntegrationGame(IntegrationGame integrationGame) {
    return _integrationGameDeletionAdapter
        .deleteAndReturnChangedRows(integrationGame);
  }
}

class _$QuestionDao extends QuestionDao {
  _$QuestionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _questionInsertionAdapter = InsertionAdapter(
            database,
            'question',
            (Question item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'answer': item.answer,
                  'lastAnswered': item.lastAnswered,
                  'card_id': item.cardId
                }),
        _questionUpdateAdapter = UpdateAdapter(
            database,
            'question',
            ['id'],
            (Question item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'answer': item.answer,
                  'lastAnswered': item.lastAnswered,
                  'card_id': item.cardId
                }),
        _questionDeletionAdapter = DeletionAdapter(
            database,
            'question',
            ['id'],
            (Question item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'answer': item.answer,
                  'lastAnswered': item.lastAnswered,
                  'card_id': item.cardId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _questionMapper = (Map<String, dynamic> row) => Question(
      row['id'] as int,
      row['title'] as String,
      row['answer'] as String,
      row['lastAnswered'] as String,
      row['card_id'] as int);

  final InsertionAdapter<Question> _questionInsertionAdapter;

  final UpdateAdapter<Question> _questionUpdateAdapter;

  final DeletionAdapter<Question> _questionDeletionAdapter;

  @override
  Future<Question> findQuestionByCardId(int id) async {
    return _queryAdapter.query('SELECT * FROM question WHERE card_id = ?',
        arguments: <dynamic>[id], mapper: _questionMapper);
  }

  @override
  Future<int> insertQuestion(Question question) {
    return _questionInsertionAdapter.insertAndReturnId(
        question, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateQuestion(Question question) {
    return _questionUpdateAdapter.updateAndReturnChangedRows(
        question, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteQuestion(Question question) {
    return _questionDeletionAdapter.deleteAndReturnChangedRows(question);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (User item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'lastName': item.lastName,
                  'email': item.email
                }),
        _userUpdateAdapter = UpdateAdapter(
            database,
            'user',
            ['id'],
            (User item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'lastName': item.lastName,
                  'email': item.email
                }),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['id'],
            (User item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'lastName': item.lastName,
                  'email': item.email
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userMapper = (Map<String, dynamic> row) => User(
      row['id'] as int,
      row['name'] as String,
      row['email'] as String,
      row['lastName'] as String);

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<User> _userUpdateAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM user', mapper: _userMapper);
  }

  @override
  Future<User> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM user WHERE id = ?',
        arguments: <dynamic>[id], mapper: _userMapper);
  }

  @override
  Future<User> findUsersByNameAndEmail(String name, String email) async {
    return _queryAdapter.query(
        'SELECT * FROM user WHERE name = ? AND email = ?',
        arguments: <dynamic>[name, email],
        mapper: _userMapper);
  }

  @override
  Future<User> findCurrentUser() async {
    return _queryAdapter.query('SELECT * FROM user WHERE id=1',
        mapper: _userMapper);
  }

  @override
  Future<int> insertUser(User user) {
    return _userInsertionAdapter.insertAndReturnId(
        user, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateUser(User user) {
    return _userUpdateAdapter.updateAndReturnChangedRows(
        user, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteUser(User user) {
    return _userDeletionAdapter.deleteAndReturnChangedRows(user);
  }
}
