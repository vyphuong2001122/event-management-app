import 'package:dio/dio.dart';
import 'package:event_management_app/main.dart';
import 'package:event_management_app/models/event.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:event_management_app/models/ticket.dart';
import 'package:event_management_app/models/user.dart';

class API {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://be-1z7j.onrender.com/',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  ));

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
        await preferences.setString('TOKEN', response.data['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Bị lỗi
      return false;
    }
  }

  // Đăng ký tài khoản
  // Nếu đăng ký thành công, trả về true
  // Nếu đăng ký thất bại, trả về false
  Future<bool> register(String email, String password, String name) async {
    try {
      Response response = await dio.post('users/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
      bool success = response.data['success'];
      // Nếu thành công, lưu lại token đăng nhập ở local
      if (success) {
        await preferences.setString('TOKEN', response.data['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Bị lỗi
      return false;
    }
  }

  void addToken() {
    String? token = preferences.getString('TOKEN');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<User?> getUserProfile() async {
    try {
      addToken();
      Response response = await dio.get('users/profile');
      bool success = response.data['success'];
      if (success) {
        return User.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return null;
    }
  }

  Future<bool> updateUserProfile({required String name}) async {
    try {
      addToken();
      Response response = await dio.put('users/profile', data: {
        'name': name,
      });
      bool success = response.data['success'];
      return success;
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return false;
    }
  }

  Future<List<User>> getUserList() async {
    try {
      addToken();
      Response response = await dio.get('users');
      bool success = response.data['success'];
      if (success) {
        List<User> users = [];
        for (Map<String, dynamic> userData in (response.data['data']
            ['users'])) {
          users.add(User.fromJson(userData));
        }
        return users;
      } else {
        return [];
      }
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return [];
    }
  }

  Future<List<Event>> getEventList() async {
    try {
      addToken();
      Response response = await dio.get('events');
      bool success = response.data['success'];
      if (success) {
        List<Event> events = [];
        for (Map<String, dynamic> eventData in (response.data['data'])) {
          events.add(Event.fromJson(eventData));
        }
        return events;
      } else {
        return [];
      }
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return [];
    }
  }

  Future<List<Ticket>> getMyTicketList() async {
    try {
      addToken();
      Response response = await dio.get('tickets/myticket');
      bool success = response.data['success'];
      if (success) {
        List<Ticket> tickets = [];
        for (Map<String, dynamic> eventData in (response.data['tickets'])) {
          tickets.add(Ticket.fromJson(eventData));
        }
        return tickets;
      } else {
        return [];
      }
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return [];
    }
  }

  Future<Event?> getEventDetail(int id) async {
    try {
      addToken();
      Response response = await dio.get('events/$id');
      bool success = response.data['success'];
      if (success) {
        return Event.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return null;
    }
  }

  Future<bool> addNewEvent(Event newEvent) async {
    try {
      addToken();
      Response response =
          await dio.post('events/create', data: newEvent.toJson());
      bool success = response.data['success'];
      return success;
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return false;
    }
  }

  Future<String?> registerForEvent(int id) async {
    try {
      addToken();
      Response response = await dio.post('events/$id/register');
      bool success = response.data['success'];
      if (success) {
        return response.data['data']['qrKey'];
      }
      return null;
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return null;
    }
  }

  Future<bool> validateAttendance(String qrKey) async {
    try {
      addToken();
      Response response = await dio.post('events/validate-attendance', data: {
        'qrKey': qrKey,
      });
      bool success = response.data['success'];
      if (success) {
        return true;
      }
      return false;
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return false;
    }
  }

  Future<List<Speaker>> getSpeakers() async {
    try {
      addToken();
      Response response = await dio.get('speakers');
      bool success = response.data['success'];
      if (success) {
        List<Speaker> speakers = [];
        for (Map<String, dynamic> eventData in (response.data['data'])) {
          speakers.add(Speaker.fromJson(eventData));
        }
        return speakers;
      } else {
        return [];
      }
    } catch (e, st) {
      // Bị lỗi
      print('$e $st');
      return [];
    }
  }
}
