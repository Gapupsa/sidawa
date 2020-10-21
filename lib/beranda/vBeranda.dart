import 'package:flutter/material.dart';
import 'package:sidawa/constants.dart';
import 'package:sidawa/models/sidawaMenuList.dart';
import 'package:sidawa/screens/guest.dart';
import 'package:sidawa/screens/reportingCase.dart';
import 'package:sidawa/screens/searchWarga.dart';
import 'package:sidawa/widgets/sidawaAppbar.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<SidawaMenu> _sidawaMenu = [];

  @override
  void initState() {
    super.initState();

    _sidawaMenu.add(new SidawaMenu(
        image: Icons.search,
        color: SidawaPalette.menuRide,
        title: "CARI-WARGA",
        myWidget: SearchWarga()));
    _sidawaMenu.add(new SidawaMenu(
        image: Icons.people_outline,
        color: SidawaPalette.menuCar,
        title: "TAMU-WARGA",
        myWidget: Guest()));
    _sidawaMenu.add(new SidawaMenu(
        image: Icons.report_problem,
        color: SidawaPalette.menuBluebird,
        title: "PENGADUAN",
        myWidget: ReportingCase()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SidawaAppBar(),
        backgroundColor: SidawaPalette.grey,
        body: Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                color: Colors.white,
                child: Column(
                  children: [
                    _buildGopayMenu(),
                    _buildSidawaMenu(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGopayMenu() {
    return new Container(
        height: 120.0,
        decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(3.0))),
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(12.0),
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
                  ),
                  borderRadius: new BorderRadius.only(
                      topLeft: new Radius.circular(3.0),
                      topRight: new Radius.circular(3.0))),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    "INFORMASI",
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "NeoSansBold"),
                  ),
                  new Container(
                    child: new Text(
                      "1.781 Warga",
                      style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: "NeoSansBold"),
                    ),
                  )
                ],
              ),
            ),
            new Container(
              padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        "assets/icons/children.png",
                        width: 32.0,
                        height: 32.0,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      new Text(
                        "80 Anak",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        "assets/icons/adult.png",
                        width: 32.0,
                        height: 32.0,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      new Text(
                        "50 Dewasa",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        "assets/icons/elderly.png",
                        width: 32.0,
                        height: 32.0,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      new Text(
                        "20 Lansia",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        "assets/icons/widow.png",
                        width: 32.0,
                        height: 32.0,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      new Text(
                        "40 Janda",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildSidawaMenu() {
    return SizedBox(
      width: double.infinity,
      height: 220.0,
      child: GridView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: 3,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, position) {
          return _rowSidawaMenu(_sidawaMenu[position]);
        },
      ),
    );
  }

  Widget _rowSidawaMenu(SidawaMenu menuSidawa) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // showModalBottomSheet<void>(
              //     context: context,
              //     builder: (context) {
              //       return _buildMenuBottomSheet();
              //     });
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return menuSidawa.myWidget;
              }));
            },
            child: new Container(
              decoration: new BoxDecoration(
                  border: Border.all(color: SidawaPalette.grey200, width: 1.0),
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(20.0))),
              padding: EdgeInsets.all(12.0),
              child: new Icon(
                menuSidawa.image,
                color: menuSidawa.color,
                size: 32.0,
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
          new Text(
            menuSidawa.title,
            style: new TextStyle(fontSize: 10.0),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
