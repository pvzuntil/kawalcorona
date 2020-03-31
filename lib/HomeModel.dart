// import 'dart:convert';

// class UserModel {
//   String name;

//   UserModel({this.name});

//   factory UserModel.parsing(Map<String, dynamic> data) {
//     return UserModel(
//       name: data['name'],
//     );
//   }

//   static Future<UserModel> getData(String id) async {
//     String urlnya = 'https://reqres.in/api/users/' + id;
//     var fetch = await ajax.get(urlnya);
//     var ress = fetch.body;
//     var data = json.decode(ress);
//     data = (data as Map<String, dynamic>)['data'];
//     print(data);
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeModel {
  String confirm, death, cover, active;

  HomeModel({
    this.confirm,
    this.death,
    this.cover,
    // this.active,
  });

  factory HomeModel.parseData(Map<dynamic, dynamic> data) {
    return HomeModel(
      confirm: data['positif'],
      death: data['meninggal'],
      cover: data['sembuh'],
      // active: data['meninggal'],
    );
  }

  static Future<HomeModel> getData(String indexData) async {
    print(indexData);
    String urlnya = 'https://api.kawalcorona.com/indonesia';
    var response = await http.get(urlnya);
    var jsonData = json.decode(response.body);
    return HomeModel.parseData(jsonData[0]);
  }
}
