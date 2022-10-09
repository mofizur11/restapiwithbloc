import 'dart:convert';

import 'package:bloc_rest_api/model/user_model.dart';
import 'package:http/http.dart';

class UserRepository {
  String url = "https://reqres.in/api/users?page2";

  getUsers() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => UserModel.fromJson(e))).toString();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
