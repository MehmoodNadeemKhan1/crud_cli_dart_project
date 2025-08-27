// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_app_database.dart';

// ignore_for_file: type=lint
class $UserDetailsTableTable extends UserDetailsTable
    with TableInfo<$UserDetailsTableTable, UserDetailDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserDetailsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthYearMeta = const VerificationMeta(
    'birthYear',
  );
  @override
  late final GeneratedColumn<String> birthYear = GeneratedColumn<String>(
    'birth_year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nationalityMeta = const VerificationMeta(
    'nationality',
  );
  @override
  late final GeneratedColumn<String> nationality = GeneratedColumn<String>(
    'nationality',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    age,
    birthYear,
    nationality,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_details_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserDetailDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('birth_year')) {
      context.handle(
        _birthYearMeta,
        birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_birthYearMeta);
    }
    if (data.containsKey('nationality')) {
      context.handle(
        _nationalityMeta,
        nationality.isAcceptableOrUnknown(
          data['nationality']!,
          _nationalityMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  UserDetailDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDetailDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      birthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_year'],
      )!,
      nationality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nationality'],
      ),
    );
  }

  @override
  $UserDetailsTableTable createAlias(String alias) {
    return $UserDetailsTableTable(attachedDatabase, alias);
  }
}

class UserDetailDb extends DataClass implements Insertable<UserDetailDb> {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String birthYear;
  final String? nationality;
  const UserDetailDb({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.birthYear,
    this.nationality,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['age'] = Variable<int>(age);
    map['birth_year'] = Variable<String>(birthYear);
    if (!nullToAbsent || nationality != null) {
      map['nationality'] = Variable<String>(nationality);
    }
    return map;
  }

  UserDetailsTableCompanion toCompanion(bool nullToAbsent) {
    return UserDetailsTableCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      age: Value(age),
      birthYear: Value(birthYear),
      nationality: nationality == null && nullToAbsent
          ? const Value.absent()
          : Value(nationality),
    );
  }

  factory UserDetailDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDetailDb(
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      age: serializer.fromJson<int>(json['age']),
      birthYear: serializer.fromJson<String>(json['birthYear']),
      nationality: serializer.fromJson<String?>(json['nationality']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'age': serializer.toJson<int>(age),
      'birthYear': serializer.toJson<String>(birthYear),
      'nationality': serializer.toJson<String?>(nationality),
    };
  }

  UserDetailDb copyWith({
    String? id,
    String? firstName,
    String? lastName,
    int? age,
    String? birthYear,
    Value<String?> nationality = const Value.absent(),
  }) => UserDetailDb(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    age: age ?? this.age,
    birthYear: birthYear ?? this.birthYear,
    nationality: nationality.present ? nationality.value : this.nationality,
  );
  UserDetailDb copyWithCompanion(UserDetailsTableCompanion data) {
    return UserDetailDb(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      age: data.age.present ? data.age.value : this.age,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
      nationality: data.nationality.present
          ? data.nationality.value
          : this.nationality,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDetailDb(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('age: $age, ')
          ..write('birthYear: $birthYear, ')
          ..write('nationality: $nationality')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, firstName, lastName, age, birthYear, nationality);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDetailDb &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.age == this.age &&
          other.birthYear == this.birthYear &&
          other.nationality == this.nationality);
}

class UserDetailsTableCompanion extends UpdateCompanion<UserDetailDb> {
  final Value<String> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<int> age;
  final Value<String> birthYear;
  final Value<String?> nationality;
  final Value<int> rowid;
  const UserDetailsTableCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.age = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.nationality = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserDetailsTableCompanion.insert({
    required String id,
    required String firstName,
    required String lastName,
    required int age,
    required String birthYear,
    this.nationality = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       firstName = Value(firstName),
       lastName = Value(lastName),
       age = Value(age),
       birthYear = Value(birthYear);
  static Insertable<UserDetailDb> custom({
    Expression<String>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? age,
    Expression<String>? birthYear,
    Expression<String>? nationality,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (age != null) 'age': age,
      if (birthYear != null) 'birth_year': birthYear,
      if (nationality != null) 'nationality': nationality,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserDetailsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<int>? age,
    Value<String>? birthYear,
    Value<String?>? nationality,
    Value<int>? rowid,
  }) {
    return UserDetailsTableCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      birthYear: birthYear ?? this.birthYear,
      nationality: nationality ?? this.nationality,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<String>(birthYear.value);
    }
    if (nationality.present) {
      map['nationality'] = Variable<String>(nationality.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserDetailsTableCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('age: $age, ')
          ..write('birthYear: $birthYear, ')
          ..write('nationality: $nationality, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserDetailsTableTable userDetailsTable = $UserDetailsTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userDetailsTable];
}

typedef $$UserDetailsTableTableCreateCompanionBuilder =
    UserDetailsTableCompanion Function({
      required String id,
      required String firstName,
      required String lastName,
      required int age,
      required String birthYear,
      Value<String?> nationality,
      Value<int> rowid,
    });
typedef $$UserDetailsTableTableUpdateCompanionBuilder =
    UserDetailsTableCompanion Function({
      Value<String> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<int> age,
      Value<String> birthYear,
      Value<String?> nationality,
      Value<int> rowid,
    });

class $$UserDetailsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserDetailsTableTable> {
  $$UserDetailsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationality => $composableBuilder(
    column: $table.nationality,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserDetailsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserDetailsTableTable> {
  $$UserDetailsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationality => $composableBuilder(
    column: $table.nationality,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserDetailsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserDetailsTableTable> {
  $$UserDetailsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);

  GeneratedColumn<String> get nationality => $composableBuilder(
    column: $table.nationality,
    builder: (column) => column,
  );
}

class $$UserDetailsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserDetailsTableTable,
          UserDetailDb,
          $$UserDetailsTableTableFilterComposer,
          $$UserDetailsTableTableOrderingComposer,
          $$UserDetailsTableTableAnnotationComposer,
          $$UserDetailsTableTableCreateCompanionBuilder,
          $$UserDetailsTableTableUpdateCompanionBuilder,
          (
            UserDetailDb,
            BaseReferences<_$AppDatabase, $UserDetailsTableTable, UserDetailDb>,
          ),
          UserDetailDb,
          PrefetchHooks Function()
        > {
  $$UserDetailsTableTableTableManager(
    _$AppDatabase db,
    $UserDetailsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserDetailsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserDetailsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserDetailsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> birthYear = const Value.absent(),
                Value<String?> nationality = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserDetailsTableCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                age: age,
                birthYear: birthYear,
                nationality: nationality,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String firstName,
                required String lastName,
                required int age,
                required String birthYear,
                Value<String?> nationality = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserDetailsTableCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                age: age,
                birthYear: birthYear,
                nationality: nationality,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserDetailsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserDetailsTableTable,
      UserDetailDb,
      $$UserDetailsTableTableFilterComposer,
      $$UserDetailsTableTableOrderingComposer,
      $$UserDetailsTableTableAnnotationComposer,
      $$UserDetailsTableTableCreateCompanionBuilder,
      $$UserDetailsTableTableUpdateCompanionBuilder,
      (
        UserDetailDb,
        BaseReferences<_$AppDatabase, $UserDetailsTableTable, UserDetailDb>,
      ),
      UserDetailDb,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserDetailsTableTableTableManager get userDetailsTable =>
      $$UserDetailsTableTableTableManager(_db, _db.userDetailsTable);
}
