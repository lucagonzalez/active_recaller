import 'package:activerecaller/persistance/db/knowledge_card.dart';
import 'package:activerecaller/persistance/db/integration_game.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'card_game',
  foreignKeys: [
    ForeignKey(
      childColumns: ['card_id'],
      parentColumns: ['id'],
      entity: KnowledgeCard
    ),
    ForeignKey(
      childColumns: ['integration_game_id'],
      parentColumns: ['id'],
      entity: IntegrationGame
    )
  ]
)
class CardGame {
  @PrimaryKey()
  @ColumnInfo(name:'card_id')
  final int cardId;

  @PrimaryKey()
  @ColumnInfo(name:'integration_game_id')
  final int integrationGameId;

  final String dateTime;

  CardGame(this.cardId, this.integrationGameId, this.dateTime);

  CardGame.createNew(this.cardId, this.integrationGameId, this.dateTime);
}