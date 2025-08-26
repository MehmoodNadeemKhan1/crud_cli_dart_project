import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'user_details_table.dart';

part 'user_detail_app_database.g.dart';

@DriftDatabase(tables: [UserDetailsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertUser(UserDetailsTableCompanion entry) =>
      into(userDetailsTable).insert(entry);

  Future<List<UserDetailDb>> getAllUsers() =>
      select(userDetailsTable).get();

  Future<UserDetailDb?> getUserById(String id) =>
      (select(userDetailsTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<bool> updateUser(UserDetailDb user) =>
      update(userDetailsTable).replace(user);

  Future<int> deleteUser(String id) =>
      (delete(userDetailsTable)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = File('my_sqlite_db.db');
    return NativeDatabase(file);
  });
}
