import 'package:activerecaller/persistance/db/question.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'knowledge_card',
  foreignKeys: [
    ForeignKey(
        childColumns: ['question_id'],
        parentColumns: ['id'],
        entity: Question,
        onUpdate: ForeignKeyAction.CASCADE,
        onDelete: ForeignKeyAction.CASCADE),
    ForeignKey(
        childColumns: ['user_id'],
        parentColumns: ['id'],
        entity: User,
        onUpdate: ForeignKeyAction.CASCADE,
        onDelete: ForeignKeyAction.CASCADE)
  ],
)
class KnowledgeCard {
  @PrimaryKey(autoGenerate: true)
  int id;

  String title;

  String quote;

  String mediaName;

  String author;

  String tags;

  String personalNote;

  @ColumnInfo(name: 'question_id')
  int questionId;

  @ColumnInfo(name: 'user_id')
  final int userId;

  KnowledgeCard(this.id, this.title, this.quote, this.mediaName, this.author,
      this.tags, this.personalNote, this.questionId, this.userId);

  KnowledgeCard.createNew(this.title, this.quote, this.mediaName, this.author,
      this.tags, this.personalNote, this.userId);
}
