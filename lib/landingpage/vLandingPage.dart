import 'package:flutter/material.dart';
import 'package:sidawa/beranda/vBeranda.dart';
import 'package:sidawa/constants.dart';
import 'package:sidawa/register/vRegister.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _btmNavCurrentIndex = 0;
  List<Widget> _container = [BerandaPage(), SignUpPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_btmNavCurrentIndex],
      bottomNavigationBar: _buildBtmNavigation(),
    );
  }

  Widget _buildBtmNavigation() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _btmNavCurrentIndex = index;
        });
      },
      currentIndex: _btmNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: SidawaPalette.green,
            ),
            icon: Icon(
              Icons.home,
              color: SidawaPalette.grey,
            ),
            label: 'Beranda'),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.people,
              color: SidawaPalette.green,
            ),
            icon: Icon(
              Icons.people,
              color: SidawaPalette.grey,
            ),
            label: 'Register'),
      ],
    );
  }
}
