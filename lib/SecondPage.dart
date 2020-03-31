import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kawalkorona/SecondModel.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA CORONA SEDUNIA'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: FutureBuilder<List<SecondModel>>(
          future: SecondModel.getListData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: (snapshot.data == null) ? 0 : snapshot.data.length,
                itemBuilder: (context, iteration) {
                  FlutterMoneyFormatter fmfInfeksi = FlutterMoneyFormatter(
                    amount: snapshot.data[iteration].confirm.toDouble(),
                  );
                  FlutterMoneyFormatter fmfDeath = FlutterMoneyFormatter(
                    amount: snapshot.data[iteration].death.toDouble(),
                  );
                  FlutterMoneyFormatter fmfCover = FlutterMoneyFormatter(
                    amount: snapshot.data[iteration].cover.toDouble(),
                  );
                  return Card(
                    child: ExpansionTile(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          width: double.maxFinite,
                          // TODO SINI
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  BuildCard(
                                    fmfInfeksi: fmfInfeksi,
                                    title: 'Terinfeksi',
                                    gambar: 'positif',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  BuildCard(
                                    fmfInfeksi: fmfDeath,
                                    title: 'Meninggal',
                                    gambar: 'death',
                                  ),
                                  BuildCard(
                                    fmfInfeksi: fmfCover,
                                    title: 'Sembuh',
                                    gambar: 'sembuh',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      title: Text(snapshot.data[iteration].negara),
                      leading: (snapshot.data[iteration].flag != null)
                          ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image: NetworkImage(
                                      snapshot.data[iteration].flag),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(
                                Icons.flag,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({Key key, @required this.fmfInfeksi, this.title, this.gambar})
      : super(key: key);

  final FlutterMoneyFormatter fmfInfeksi;
  final String title, gambar;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Card(
        elevation: 6,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Image(
                  image: AssetImage('assets/image/' + gambar + '.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(title),
              Text(
                fmfInfeksi.output.withoutFractionDigits,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetBagian extends StatefulWidget {
  String title;
  Color warna;

  WidgetBagian({this.title, this.warna});

  @override
  _WidgetBagianState createState() => _WidgetBagianState();
}

class _WidgetBagianState extends State<WidgetBagian> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        color: Colors.green,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.warna,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.title),
                Text('Banyal'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
