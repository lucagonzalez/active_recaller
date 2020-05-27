import 'package:floor/floor.dart';

@Entity(
  tableName: "user"
)
class User {
  @PrimaryKey(autoGenerate: true)
  int id;

  final String name;

  final String lastName;

  final String email;

  User(this.id, this.name, this.email, this.lastName);

  User.createNew(this.name, this.lastName, this.email);
}
