import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants/string_constant.dart';

class SPHelper {
  static Future<void> setUserName({required String username}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StringConstant.username, username);
  }

  static Future<String?> getUserName() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String? userName =
        sharedPreferences.getString(StringConstant.username);
    return userName;
  }

  static Future<void> setUserPassword({required String password}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StringConstant.password, password);
  }

  static Future<String?> getUserPassword() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String? password =
        sharedPreferences.getString(StringConstant.password);
    return password;
  }

  static Future<void> setUserEmailId({required String emailId}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StringConstant.emailId, emailId);
  }

  static Future<String?> getUserEmail() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String? emailId = sharedPreferences.getString(StringConstant.emailId);
    return emailId;
  }

  static Future<void> setContactNo({required String contactNo}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StringConstant.contactNo, contactNo);
  }

  static Future<String?> getContactNo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String? contactNo =
        sharedPreferences.getString(StringConstant.contactNo);
    return contactNo;
  }

  static Future<void> setLocation({required String location}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StringConstant.location, location);
  }

  static Future<String?> getLocation() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String? location =
        sharedPreferences.getString(StringConstant.location);
    return location;
  }
}
