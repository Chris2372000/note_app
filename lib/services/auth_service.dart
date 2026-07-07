class AuthService {
  static const String username = "admin";
  static const String password = "1234";

  static bool login(String user, String pass) {
    return user == username && pass == password;
  }
}