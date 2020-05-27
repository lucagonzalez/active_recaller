import 'package:floor/floor.dart';

import 'knowledge_card.dart';

@Entity(
  tableName: 'question',
  foreignKeys: [
    ForeignKey(
      childColumns: ['card_id'],
      parentColumns: ['id'],
      entity: KnowledgeCard,
      onDelete: ForeignKeyAction.CASCADE
    ),
  ]
)
class Question {
  @PrimaryKey(autoGenerate: true)
  int id;

  String title;

  String answer;

  String lastAnswered;

  @ColumnInfo(name: 'card_id')
  int cardId;

  Question(this.id, this.title, this.answer, this.lastAnswered, this.cardId);

  Question.createNew(this.title, this.answer, this.lastAnswered, this.cardId);
}