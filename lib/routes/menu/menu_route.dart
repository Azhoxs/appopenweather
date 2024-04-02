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
    // Obtenez l'heure actuelle
    int hour = DateTime.now().hour;

    // Déterminez le nom de l'image de fond en fonction de l'heure
    String backgroundImage;
    if (hour >= 6 && hour < 11) {
      backgroundImage = 'backgrounds/1.jpg';
    } else if (hour >= 11 && hour < 18) {
      backgroundImage = 'backgrounds/2.jpg';
    } else if (hour >= 18 && hour < 21) {
      backgroundImage = 'backgrounds/3.jpg';
    } else {
      backgroundImage = 'backgrounds/4.jpg';
    }

    switch (_currentIndex) {
      case 0:
        return FutureBuilder<double>(
          future: WeatherTemperature.getTemperature('Paris').then((value) => double.parse(value)),
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError)
                return Center(child: Text('Erreur: ${snapshot.error}'));
              else {
                int roundedTemperature = snapshot.data?.round() ?? 0;
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(backgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$roundedTemperature°C',
                          style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'Paris',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          },
        );
      case 1:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text('Contenu de la page Villes'),
          ),
        );
      default:
        return Container();
    }
  }
}