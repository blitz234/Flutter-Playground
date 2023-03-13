import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool _obscure = false;

  bool get loading => _loading;
  bool get obscure => _obscure;

  void setLoading() {
    _loading = !_loading;
    notifyListeners();
  }

  void setObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  void login(String email, String password) async {
    setLoading();
    try {
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        debugPrint("Login Successful");
        setLoading();
      } else {
        debugPrint("Login Failed");
        setLoading();
      }
    } catch (e) {
      debugPrint(e.toString());
      setLoading();
    }
  }
}
