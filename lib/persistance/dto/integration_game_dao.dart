import 'package:activerecaller/persistance/db/integration_game.dart';
import 'package:floor/floor.dart';

@dao
abstract class IntegrationGameDao {
  @Query('SELECT * FROM integration_game WHERE integration_game.id = :id')
  Future<IntegrationGame> findIntegrationGameById(int id);

  @Query('SELECT * FROM integration_game WHERE integration_game.user_id = :id')
  Future<List<IntegrationGame>> findAllIntegrationGamesByUserId(int id);

  @insert
  Future<int> insertIntegrationGame(IntegrationGame integrationGame);

  @update
  Future<int> updateIntegrationGame(IntegrationGame integrationGame);

  @delete
  Future<int> deleteIntegrationGame(IntegrationGame integrationGame);
}