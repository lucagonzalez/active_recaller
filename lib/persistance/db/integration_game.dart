import 'package:activerecaller/persistance/db/user.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'integration_game',
  foreignKeys: [
    ForeignKey(
      childColumns: ['user_id'],
      parentColumns: ['id'],
      entity: User,
    )
  ],
)
class IntegrationGame {
  @PrimaryKey(autoGenerate: true)
  int id;

  final int score;

  final String dateTime;

  @ColumnInfo(name: 'user_id')
  final int userId;

  IntegrationGame(this.id, this.score, this.dateTime, this.userId);

  IntegrationGame.createNew(this.score, this.dateTime, this.userId);
}