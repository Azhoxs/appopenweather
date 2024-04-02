import 'package:flutter/material.dart';

class MenuRoute extends StatefulWidget {
  const MenuRoute({Key? key}) : super(key: key);

  @override
  _MenuRouteState createState() => _MenuRouteState();
}

class _MenuRouteState extends State<MenuRoute> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Météo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Villes',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return Container(
          // Contenu de la page Météo
          child: Center(
            child: Text('Contenu de la page Météo'),
          ),
        );
      case 1:
        return Container(
          // Contenu de la page Villes
          child: Center(
            child: Text('Contenu de la page Villes'),
          ),
        );
      default:
        return Container();
    }
  }
}
