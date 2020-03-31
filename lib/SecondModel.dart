import 'dart:convert';

import 'package:alpha2_countries/alpha2_countries.dart';
import 'package:http/http.dart' as ajax;

class SecondModel {
  String negara, flag;
  int confirm, death, cover, active;

  SecondModel({
    this.negara,
    this.confirm,
    this.death,
    this.cover,
    this.active,
    this.flag,
  });

  factory SecondModel.parse(Map<dynamic, dynamic> data) {
    return SecondModel(
      negara: data['Country_Region'],
      confirm: data['Confirmed'],
      death: data['Deaths'],
      cover: data['Recovered'],
      active: data['Active'],
      flag: data['flag'],
    );
  }

  static Future<List<SecondModel>> getListData() async {
    String urlnya = 'https://api.kawalcorona.com/';
    ajax.Response response = await ajax.get(urlnya);
    var result = json.decode(response.body);

    List listResult = [];
    for (int i = 0; i < result.length; i++) {
      if (i == 36) {
        continue;
      }
      var data = result[i]['attributes'];
      final countries = Countries();
      final code = countries.resolveCode(data['Country_Region']);
      String urlImage = 'https://www.countryflags.io/$code/flat/64.png';
      data['flag'] = (code == null) ? null : urlImage;
      listResult.add(data);
    }

    List<SecondModel> listAkhir = [];
    for (int i = 0; i < listResult.length; i++) {
      listAkhir.add(SecondModel.parse(listResult[i]));
    }

    return listAkhir;
  }
}
