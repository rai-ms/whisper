import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/user_model.dart';

class UserData
{

  static Future<UserModel> getUser() async
  {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String ? token = preferences.getString('token');
    return UserModel(
        token: token.toString()
    );
  }

  static Future<bool> saveUser(UserModel user) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', user.token.toString());
    return true;
  }

  static void removeUser() async
  {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    preferences.clear();
  }
}