import 'package:flutter/material.dart';
import '../../app/common/WeatherTemperature.dart';

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
        return FutureBuilder<String>(
          future: WeatherTemperature.getTemperature('Paris'),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError)
                return Center(child: Text('Erreur: ${snapshot.error}'));
              else
                return Center(
                  child: Text(snapshot.data != null
                      ? 'Température à Paris: ${double.parse(snapshot.data!).round()}°C'
                      : 'Chargement...',
                  ),
                );


            }
          },
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