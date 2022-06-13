import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  /// DB 더 추가하려면 17개의 인자를 추가해야함
  /// UserProfile: 필드, 생성자 [UserProfile], 파이어베이스 전달 함수 [UserProfile.fromMap], toMap 함수 [toMap]
  /// DataBase: DB 저장함수, DB 불러오기 함수, UserProfile 받아서 저장하기 함수
  /// Firebase Storage 직접 추가
  ///
  // user
  String uid; // 유저 id
  String nickname; // 닉네임
  int authLevel; // 자신의 권한 1 = user, 2= teacher, 3 = parents, 10 = master
  String provider; // 로그인 환경
  String authId; // firebase authId: 카카오 로그인시 id가 뭔지 확인하기 위해서
  // school
  String schoolLocalCode; // 학교 교육청 코드
  int schoolCode; // 학교 코드
  String schoolName; // 학교 이름
  int schoolLevel; // 1 = 초등학교, 2 = 중학교, 3 = 고등학교
  int grade; // 학년
  int Class; // 반
  String certifiedSchoolCode; // 인증 받은 학교 코드

  UserProfile(
      {this.uid = 'guest',
      this.nickname = '',
      this.authLevel = 1,
      this.provider = "",
      this.authId = "",
      this.grade = 1,
      this.Class = 1,
      this.schoolLocalCode = "J10", // 북고만 서비스 할거면 필요없음
      this.schoolName = "부천북고등학교", // 북고만 서비스 할거면 필요없음
      this.schoolLevel = 3, // 북고만 서비스 할거면 필요없음
      this.schoolCode = 7530072, // 북고만 서비스 할거면 필요없음
      this.certifiedSchoolCode = "null"});

  static UserProfile? _current;

  static initializeUser() async {
    SavePro savePro = await SavePro.Instance();
    _current = savePro.getUserProfile();
  }

  static UserProfile get currentUser {
    if (_current != null) {
      return _current!;
    } else {
      print("Warning: 유저 초기화가 필요합니다.");
      return _current!;
    }
  }

  static Future<void> save(UserProfile userProfile) async {
    _current = userProfile;
    print("static User update");
    SavePro savePro = await SavePro.Instance();
    savePro.setUserProfile(userProfile);
  }

  factory UserProfile.guest() {
    return UserProfile(
      uid: 'guest',
      nickname: 'guest',
      authLevel: 1,
    );
  }

  factory UserProfile.fromMap(Map map) {
    UserProfile user = UserProfile();
    return UserProfile(
      uid: map['uid'] ?? user.uid,
      authLevel: map['authLevel'] ?? user.authLevel,
      Class: map['class'] ?? user.Class,
      grade: map['grade'] ?? user.grade,
      provider: map['provider'] ?? user.provider,
      authId: map['authId'] ?? user.authId,
      nickname: map['nickname'] ?? user.nickname,
      schoolLocalCode: map['schoolLocalCode'] ?? user.schoolLocalCode,
      schoolName: map['schoolName'] ?? user.schoolName,
      schoolCode: map['schoolCode'] ?? user.schoolCode,
      schoolLevel: map['schoolLevel'] ?? user.schoolLevel,
      certifiedSchoolCode:
          map['certifiedSchoolCode'] ?? user.certifiedSchoolCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'authLevel': authLevel,
      'class': Class,
      'grade': grade,
      'provider': provider,
      'authId': authId,
      'nickname': nickname,
      'schoolLocalCode': schoolLocalCode,
      'schoolName': schoolName,
      'schoolCode': schoolCode,
      'schoolLevel': schoolLevel,
      'certifiedSchoolCode': certifiedSchoolCode,
    };
  }

  @override
  String toString() => toMap().toString();
}

class UserProfileHandler extends UserProfile {
  UserProfileHandler.SwitchGuest() {
    print("Local DB 게스트 상태로 변경");
    UserProfile userProfile = UserProfile.guest();
    UserProfile.save(userProfile);
  }
}

class SavePro {
  // _set 하는것은 Instance가 필요 없지만
  // _get 은 퓨처값을 주지 말아야 하기 때문에 Instance가 필요하다.
  late SharedPreferences prefs;

  static Instance() async {
    SavePro key = SavePro();
    key.prefs = await SharedPreferences.getInstance();
    return key;
  }

  UserProfile userProfile = UserProfile();

  /// _set
  _setGrade(int Grade) => prefs.setInt('Grade', Grade);

  _setClass(int Class) => prefs.setInt('Class', Class);

  _setCityCode(String CityCode) => prefs.setString("CityCode", CityCode);

  _setSchoolCode(int SchoolCode) => prefs.setInt('SchoolCode', SchoolCode);

  _setUid(String uid) => prefs.setString('ID', uid);

  _setNickName(String nickname) => prefs.setString('Nickname', nickname);

  _setAuthLevel(int auth) => prefs.setInt('AuthLevel', auth);

  _setSchoolName(String name) => prefs.setString('schoolName', name);

  _setSchoolLevel(int level) => prefs.setInt('schoolLevel', level);

  _setCertifiedSchoolCode(String certified) =>
      prefs.setString('certifiedSchoolCode', certified);

  _setProvider(String provider) => prefs.setString('provider', provider);

  _setAuthId(String authId) => prefs.setString('authId', authId);

  /// _get
  int _getGrade() => prefs.getInt('Grade') ?? userProfile.grade;

  int _getClass() => prefs.getInt('Class') ?? userProfile.Class;

  String _getSchoolLocalCode() =>
      prefs.getString('schoolLocalCode') ?? userProfile.schoolLocalCode;

  int _getSchoolCode() => prefs.getInt('SchoolCode') ?? userProfile.schoolCode;

  String _getUid() => prefs.getString('ID') ?? userProfile.uid;

  String _getNickName() => prefs.getString('Nickname') ?? userProfile.nickname;

  int _getAuthLevel() => prefs.getInt('AuthLevel') ?? userProfile.authLevel;

  String _getSchoolName() =>
      prefs.getString('schoolName') ?? userProfile.schoolName;

  int _getSchoolLevel() =>
      prefs.getInt('schoolLevel') ?? userProfile.schoolLevel;

  String _getCertifiedSchoolCode() =>
      prefs.getString('certifiedSchoolCode') ?? userProfile.certifiedSchoolCode;

  String _getProvider() => prefs.getString('provider') ?? userProfile.provider;

  String _getAuthId() => prefs.getString('authId') ?? userProfile.authId;

  UserProfile getUserProfile() {
    return UserProfile(
        uid: _getUid(),
        nickname: _getNickName(),
        authLevel: _getAuthLevel(),
        provider: _getProvider(),
        authId: _getAuthId(),
        grade: _getGrade(),
        Class: _getClass(),
        schoolLocalCode: _getSchoolLocalCode(),
        schoolCode: _getSchoolCode(),
        schoolName: _getSchoolName(),
        schoolLevel: _getSchoolLevel(),
        certifiedSchoolCode: _getCertifiedSchoolCode());
  }

  setUserProfile(UserProfile userProfile) {
    _setUid(userProfile.uid);
    _setNickName(userProfile.nickname);
    _setAuthLevel(userProfile.authLevel);
    _setProvider(userProfile.provider);
    _setAuthId(userProfile.authId);
    _setGrade(userProfile.grade);
    _setClass(userProfile.Class);
    _setSchoolCode(userProfile.schoolCode);
    print('Local DB: 유저 저장');
  }
}
