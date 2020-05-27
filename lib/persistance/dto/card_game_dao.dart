import 'package:activerecaller/persistance/db/card_game.dart';
import 'package:floor/floor.dart';

@dao
abstract class CardGameDao {
  @Query('SELECT * FROM card_game WHERE id = :id')
  Future<CardGame> findCardGameById(int id);

  @Query('SELECT * FROM card_game WHERE card_id = :id')
  Future<List<CardGame>> findAllCardGamesByCardId(int id);

  @Query('SELECT * FROM card_game WHERE integration_game_id = :id')
  Future<List<CardGame>> findAllCardGamesByIntegrationGameIdId(int id);

  @insert
  Future<int> createCardGame(CardGame cardGame);

  @delete
  Future<int> deleteCardGame(CardGame cardGame);
}