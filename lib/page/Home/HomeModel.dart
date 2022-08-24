import 'package:flutter/cupertino.dart';
import 'package:flutterschool/page/Home/timetable.dart';

import '../../DB/userProfile.dart';
import 'Lunch/Lunch.dart';
import 'Lunch/lunchSlider.dart';

class HomeModel with ChangeNotifier {
  HomeModel() {
    UserSchool userProfile = UserProfile.currentUser;
    setTimeTable(userProfile);
    setLunch(userProfile);
    _grade = userProfile.grade;
    _class = userProfile.Class;
    _schoolName = userProfile.name;
  }

  late int _grade;
  late int _class;
  late String _schoolName;

  Map<String, Lunch>? _lunchMap;
  ClassData? _classData;

  int get grade => _grade;

  int get Class => _class;

  String get schoolName => _schoolName;

  Map<String, Lunch>? get lunchMap => _lunchMap;

  ClassData? get classData => _classData;

  Future<void> setTimeTable(UserSchool userProfile) async {
    _changeProfile(userProfile);

    print("${userProfile.grade}학년 ${userProfile.Class}반 시간표 불러오는 중...");
    TableDownloader tabledown = TableDownloader(
      Grade: userProfile.grade,
      Class: userProfile.Class,
      SchoolCode: userProfile.code,
      CityCode: userProfile.officeCode,
      schoolLevel: userProfile.level,
    );
    await tabledown.downLoad();

    _classData = tabledown.getData();

    notifyListeners();
  }

  Future<void> setLunch(UserSchool userProfile) async {
    _changeProfile(userProfile);

    print("${userProfile.name} 급식 불러오는 중...");
    LunchDownload lunchDownload = LunchDownload(
        schoolCode: userProfile.code, cityCode: userProfile.officeCode);
    var json = await lunchDownload.getJson(lunchDownload.uriPast);

    JsonToLunch jsonToLunch = JsonToLunch(json: json);

    _lunchMap = jsonToLunch.currentLunch(true);
    notifyListeners();
  }

  _changeProfile(UserSchool userProfile){
    _grade = userProfile.grade;
    _class = userProfile.Class;
    _schoolName = userProfile.name;
  }
}
