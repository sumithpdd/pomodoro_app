// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class PomodoroType extends _PomodoroType with RealmObject {
  PomodoroType(
    int id, {
    String? typeLabel,
    int? timeInMinutes,
    bool? isReverse,
  }) {
    RealmObject.set(this, 'id', id);
    this.typeLabel = typeLabel;
    this.timeInMinutes = timeInMinutes;
    this.isReverse = isReverse;
  }

  PomodoroType._();

  @override
  int get id => RealmObject.get<int>(this, 'id') as int;
  @override
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  String? get typeLabel =>
      RealmObject.get<String>(this, 'typeLabel') as String?;
  @override
  set typeLabel(String? value) => RealmObject.set(this, 'typeLabel', value);

  @override
  int? get timeInMinutes => RealmObject.get<int>(this, 'timeInMinutes') as int?;
  @override
  set timeInMinutes(int? value) =>
      RealmObject.set(this, 'timeInMinutes', value);

  @override
  bool? get isReverse => RealmObject.get<bool>(this, 'isReverse') as bool?;
  @override
  set isReverse(bool? value) => RealmObject.set(this, 'isReverse', value);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(PomodoroType._);
    return const SchemaObject(PomodoroType, [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('typeLabel', RealmPropertyType.string, optional: true),
      SchemaProperty('timeInMinutes', RealmPropertyType.int, optional: true),
      SchemaProperty('isReverse', RealmPropertyType.bool, optional: true),
    ]);
  }
}

class UserRunHistory extends _UserRunHistory with RealmObject {
  UserRunHistory(
    int id,
    int updatedTime, {
    PomodoroType? pomodoroType,
    int? stopTimeInMinutes,
  }) {
    RealmObject.set(this, 'id', id);
    this.pomodoroType = pomodoroType;
    this.stopTimeInMinutes = stopTimeInMinutes;
    this.updatedTime = updatedTime;
  }

  UserRunHistory._();

  @override
  int get id => RealmObject.get<int>(this, 'id') as int;
  @override
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  PomodoroType? get pomodoroType =>
      RealmObject.get<PomodoroType>(this, 'pomodoroType') as PomodoroType?;
  @override
  set pomodoroType(covariant PomodoroType? value) =>
      RealmObject.set(this, 'pomodoroType', value);

  @override
  int? get stopTimeInMinutes =>
      RealmObject.get<int>(this, 'stopTimeInMinutes') as int?;
  @override
  set stopTimeInMinutes(int? value) =>
      RealmObject.set(this, 'stopTimeInMinutes', value);

  @override
  int get updatedTime => RealmObject.get<int>(this, 'updatedTime') as int;
  @override
  set updatedTime(int value) => RealmObject.set(this, 'updatedTime', value);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(UserRunHistory._);
    return const SchemaObject(UserRunHistory, [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('pomodoroType', RealmPropertyType.object,
          optional: true, linkTarget: 'PomodoroType'),
      SchemaProperty('stopTimeInMinutes', RealmPropertyType.int,
          optional: true),
      SchemaProperty('updatedTime', RealmPropertyType.int),
    ]);
  }
}
