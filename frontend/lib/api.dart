import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://be-1z7j.onrender.com/',
  ));
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  // Đăng nhập
  // Nếu đăng nhập thành công, trả về true
  // Nếu đăng nhập thất bại, trả về false
  Future<bool> login(String email, String password) async {
    try {
      Response response = await dio.post('users/login', data: {
        'email': email,
        'password': password,
      });
      bool success = response.data['success'];
      // Nếu thành công, lưu lại token đăng nhập ở local
      if (success) {
        await asyncPrefs.setString('TOKEN', response.data['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Bị lỗi
      return false;
    }
  }
}
