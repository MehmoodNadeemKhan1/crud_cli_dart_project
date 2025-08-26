import 'package:drift/drift.dart';

import 'implementation_interface.dart';
import 'user_details_model.dart'; // Freezed model
import 'user_detail_app_database.dart';

class UserDetailsDatabaseRepository implements IRepository<UserDetails> {
  final AppDatabase db;
  UserDetailsDatabaseRepository(this.db);
  @override
  Future<void> create(UserDetails item) async {
    final data = item.data;
    await db.insertUser(
      UserDetailsTableCompanion.insert(
        id: data?.userId?.toString() ?? "0",
        firstName: data?.firstName ?? "Unknown",

        lastName: data?.lastName == null
            ? const Value.absent()
            : Value(data!.lastName!),

        age: data?.age == null
            ? const Value.absent()
            : Value(data!.age!),

        birthYear: data?.birthYear == null
            ? const Value.absent()
            : Value(data!.birthYear!),

        nationality: data?.nationality == null
            ? const Value.absent()
            : Value(data!.nationality!),
      ),
    );
  }

  @override
  Future<List<UserDetails>> list() async {
    final users = await db.getAllUsers();
    return users.map((u) {
      return UserDetails(
        id: u.id.toString(),
        name: "${u.firstName} ${u.lastName ?? ''}".trim(),
        createdAt: null,
        data: UserData(
          userId: u.id.toString(),
          firstName: u.firstName,
          lastName: u.lastName,
          age: u.age,
          birthYear: u.birthYear,
          nationality: u.nationality,
        ),
      );
    }).toList();
  }

  @override
  Future<UserDetails?> findById(String id) async {
    final user = await db.getUserById(id);
    if (user == null) return null;
    return UserDetails(
      id: user.id.toString(),
      name: "${user.firstName ?? ''} ${user.lastName ?? ''}".trim(),
      createdAt: null,
      data: UserData(
        userId: user.id.toString(),
        firstName: user.firstName,
        lastName: user.lastName,
        age: user.age,
        birthYear: user.birthYear,
        nationality: user.nationality,
      ),
    );
  }

  @override
  Future<void> update(String id, UserDetails updatedItem) async {
    final data = updatedItem.data!;
    await db.updateUser(
      UserDetailDb(
        id: id,
        firstName: data!.firstName!.toString(),
        lastName: data.lastName,
        age: data.age,
        birthYear: data.birthYear,
        nationality: data.nationality,
      ),
    );
  }

  @override
  Future<void> delete(String id) async {
    await db.deleteUser(id);
  }

  @override
  Future<void> deleteAll() async {
    await db.delete(db.userDetailsTable).go();
  }
}
