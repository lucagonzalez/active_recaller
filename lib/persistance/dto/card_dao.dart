import 'package:floor/floor.dart';
import 'package:activerecaller/persistance/db/knowledge_card.dart';

@dao
abstract class KnowledgeCardDao {
  @Query('SELECT * FROM knowledge_card WHERE user_id = :id')
  Future<List<KnowledgeCard>> findAllCardsByUserId(int id);

  @Query('SELECT * FROM knowledge_card WHERE id = :id')
  Future<KnowledgeCard> findCardById(int id);

  @Query('SELECT * FROM knowledge_card WHERE question_id = :id')
  Future<KnowledgeCard> findCardByQuestionId(int id);

  @insert
  Future<int> insertCard(KnowledgeCard card);

  @update
  Future<int> updateCard(KnowledgeCard card);

  @delete
  Future<int> deleteCard(KnowledgeCard card);
}