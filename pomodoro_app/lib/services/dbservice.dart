// ignore_for_file: avoid_print

import 'package:realm/realm.dart';

import '../data/data.dart';
import '../models/model.dart';

class DatabaseService {
  late Realm realm;
  DatabaseService() {
    final config = Configuration([PomodoroType.schema, UserRunHistory.schema]);
    // delete when schema is changed cannot find any other way for windows
    //Realm.deleteRealm(config.path);
    realm = Realm(config);
  }
  int get pomodoroTypeCount => realm.all<PomodoroType>().length;

  seedData() {
    deleteAllPomodoroType();
    deleteAllUserRunHistory();
    var allItems = realm.all<PomodoroType>();

    if (allItems.isEmpty) {
      realm.write(() {
        realm.addAll(pomodoroData);
      });
    }
  }

  RealmResults<PomodoroType> getAllPomodoroType() {
    print("Getting all PomodoroType from the Realm.");
    var pomodoroType = realm.all<PomodoroType>();
    return pomodoroType;
  }

  void deleteAllPomodoroType() {
    print("Getting all PomodoroType from the Realm.");
    realm.write(() {
      var pomodoroType = realm.all<PomodoroType>();
      realm.deleteMany(pomodoroType);
    });
  }

  void deleteAllUserRunHistory() {
    realm.write(() {
      var userRunHistory = realm.all<UserRunHistory>();
      realm.deleteMany(userRunHistory);
    });
  }

  RealmResults<PomodoroType> searchPomodoroTypeByLabel(String typeLabel) {
    print("Getting all $typeLabel PomodoroType from the Realm.");
    var filteredPomodoroType =
        realm.all<PomodoroType>().query("typeLabel == '$typeLabel'");
    print('Found ${filteredPomodoroType.length} $typeLabel PomodoroType');
    return filteredPomodoroType;
  }

  void saveUserRunHistory(PomodoroType pomodoroType) {
    realm.write(() {
      UserRunHistory userRunHistory = UserRunHistory(
          getUserRunHistoryLastId(), DateTime.now().millisecondsSinceEpoch);
      userRunHistory.pomodoroType = pomodoroType;
      userRunHistory.stopTimeInMinutes = pomodoroType.timeInMinutes!;
      realm.add(userRunHistory);
      print('saved ${userRunHistory.id}');
    });
  }

//primary key trying to get unique id
  int getUserRunHistoryLastId() {
    var lastUserRunHistory = realm.all<UserRunHistory>().length;
    if (lastUserRunHistory == 0) {
      return 1;
    } else {
      return lastUserRunHistory + 1;
    }
  }

  void savePomodoroType(
      PomodoroType pomodoroType, String savetypeLabel, int timeInMinutes) {
    realm.write(() {
      pomodoroType.typeLabel = savetypeLabel;
      pomodoroType.timeInMinutes = timeInMinutes;
    });
  }

  void dispose() {
    realm.close();
  }
}
