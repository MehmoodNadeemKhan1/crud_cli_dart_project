import 'package:drift/drift.dart';


@DataClassName('UserDetailDb')
class UserDetailsTable extends Table {
  TextColumn get id => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  IntColumn get age => integer()();
  TextColumn get birthYear => text()();
  TextColumn get nationality => text().nullable()();
}
