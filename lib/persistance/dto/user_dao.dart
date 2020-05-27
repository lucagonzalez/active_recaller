import 'package:activerecaller/persistance/db/user.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM user')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM user WHERE id = :id')
  Future<User> findUserById(int id);

  @Query("SELECT * FROM user WHERE name = :name AND email = :email")
  Future<User> findUsersByNameAndEmail(String name, String email);

  @Query("SELECT * FROM user WHERE id=1")
  Future<User> findCurrentUser();

  @insert
  Future<int> insertUser(User user);

  @update
  Future<int> updateUser(User user);

  @delete
  Future<int> deleteUser(User user);
}