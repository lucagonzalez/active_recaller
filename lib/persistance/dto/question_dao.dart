import 'package:activerecaller/persistance/db/question.dart';
import 'package:floor/floor.dart';

@dao
abstract class QuestionDao {
  @Query('SELECT * FROM question WHERE card_id = :id')
  Future<Question> findQuestionByCardId(int id);

  @insert
  Future<int> insertQuestion(Question question);

  @update
  Future<int> updateQuestion(Question question);

  @delete
  Future<int> deleteQuestion(Question question);
}