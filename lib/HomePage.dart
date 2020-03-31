import 'package:flutter/material.dart';
import 'package:kawalkorona/HomeModel.dart';
import 'package:kawalkorona/SecondPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel getData;
  @override
  void initState() {
    super.initState();
    HomeModel.getData(_ContentState().indexData).then((onValue) {
      getData = onValue;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width.toString() + ' WIDTH');
    print(MediaQuery.of(context).size.height.toString() + ' HEIGHT');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 85, 185, 243),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Title(),
              Content(
                data: getData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final HomeModel data;

  Content({this.data});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String indexData;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: Material(
            elevation: 30,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                // color: Colors.red,
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Current Country',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'INDONESIA',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CardOne(
                    data: widget.data,
                  ),
                  CardTwoThree(
                    data: widget.data,
                  ),
                  CardFour(
                    data: widget.data,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 40),
                      child: RaisedButton(
                        onPressed: () async {
                          indexData = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SecondPage();
                              },
                            ),
                          );
                        },
                        child: Text('LIHAT SEMUA NEGARA'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
        width: double.infinity,
        height: (MediaQuery.of(context).size.height / 1.36),
      ),
    );
  }
}

class CardFour extends StatefulWidget {
  final HomeModel data;
  CardFour({this.data});

  @override
  _CardFourState createState() => _CardFourState();
}

class _CardFourState extends State<CardFour> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 35,
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          BuildCard(
            title: 'Sisa',
            many: (widget.data == null)
                ? '...'
                : (int.parse(widget.data.confirm.replaceAll(",", "")) -
                        (int.parse(widget.data.death.replaceAll(",", "")) +
                            int.parse(widget.data.cover.replaceAll(",", ""))))
                    .toString(),
          ),
        ],
      ),
    );
  }
}

class CardTwoThree extends StatefulWidget {
  final HomeModel data;
  CardTwoThree({this.data});

  @override
  _CardTwoThreeState createState() => _CardTwoThreeState();
}

class _CardTwoThreeState extends State<CardTwoThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 35,
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          BuildCard(
            right: 10,
            title: 'Meninggal',
            many: (widget.data == null) ? '...' : widget.data.death.toString(),
          ),
          BuildCard(
            left: 10,
            title: 'Sembuh',
            many: (widget.data == null) ? '...' : widget.data.cover.toString(),
          ),
        ],
      ),
    );
  }
}

class CardOne extends StatefulWidget {
  final HomeModel data;

  CardOne({this.data});

  @override
  _CardOneState createState() => _CardOneState();
}

class _CardOneState extends State<CardOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 35,
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          BuildCard(
            title: 'Terinfeksi',
            // many: '98',
            many:
                (widget.data == null) ? '...' : widget.data.confirm.toString(),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 85, 185, 243),
            borderRadius: BorderRadius.circular(
              50,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 72, 157, 207),
                offset: Offset.fromDirection(20, 20),
                blurRadius: 20,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 98, 213, 255),
                offset: Offset.fromDirection(20, -20),
                blurRadius: 20,
              )
            ]),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 40),
        width: double.infinity,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 20, left: 20, right: 20),
        child: Text(
          'Kawal COVID-19',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class BuildCard extends StatefulWidget {
  final double left, right;
  final String title, many;

  BuildCard({this.left = 0, this.right = 0, this.title, this.many});
  @override
  _BuildCardState createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: MediaQuery.of(context).size.height / 35,
        ),
        margin: EdgeInsets.only(
          right: widget.right,
          left: widget.left,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 230, 230),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(225, 189, 189, 189),
              offset: Offset.fromDirection(1, 5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Color.fromARGB(225, 255, 255, 255),
              offset: Offset.fromDirection(1, -6),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.many,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
