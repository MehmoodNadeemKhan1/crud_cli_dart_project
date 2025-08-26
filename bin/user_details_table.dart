import 'package:drift/drift.dart';

@DataClassName('UserDetailDb')
class UserDetailsTable extends Table {
  TextColumn get id => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text().nullable()();
  IntColumn get age => integer().nullable()();
  TextColumn get birthYear => text().nullable()();
  TextColumn get nationality => text().nullable()();
}
