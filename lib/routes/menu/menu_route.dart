import 'package:flutter/material.dart';
import '../../app/common/WeatherTemperature.dart';
import '../../app/common/WeatherIcon.dart';


class MenuRoute extends StatefulWidget {
  const MenuRoute({Key? key}) : super(key: key);

  @override
  _MenuRouteState createState() => _MenuRouteState();
}

class _MenuRouteState extends State<MenuRoute> {
  int _currentIndex = 0;
  List<String> _cities = [];
  String favoriteCity = 'Calais';

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

  void _addCity() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter une ville'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Entrez le nom d'une ville"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ajouter'),
              onPressed: () {
                String cityName = _controller.text;
                setState(() {
                  _cities.add(cityName);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ville ajoutée : $cityName'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody() {
    // Obtiens l'heure actuelle
    int hour = DateTime.now().hour;

    // Détermine le nom de l'image de fond en fonction de l'heure
    String backgroundImage;
    if (hour >= 12 && hour < 16) {
      backgroundImage = 'backgrounds/2.jpg';
    } else {
      backgroundImage = 'backgrounds/4.jpg';
    }

    switch (_currentIndex) {
      case 0:
        return FutureBuilder<double>(
          future: WeatherTemperature.getTemperature(favoriteCity).then((value) => double.parse(value)), // Remplacez 'Paris' par favoriteCity
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
                          favoriteCity,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        FutureBuilder<double>(
                          future: WeatherTemperature.getTemperature(favoriteCity).then((value) => double.parse(value)),
                          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              if (snapshot.hasError)
                                return Text('Erreur: ${snapshot.error}');
                              else {
                                int roundedTemperature = snapshot.data?.round() ?? 0;
                                return Text(
                                  '$roundedTemperature°',
                                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white),
                                );
                              }
                            }
                          },
                        ),
                        FutureBuilder<String>(
                          future: WeatherCondition.getCondition(favoriteCity),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              if (snapshot.hasError)
                                return Text('Erreur: ${snapshot.error}');
                              else {
                                String condition = snapshot.data ?? 'default';
                                String iconPath;
                                switch (condition.toLowerCase()) {
                                  case 'clear':
                                    iconPath = 'icons/weather/day/soleil1.png';
                                    break;
                                  case 'clouds':
                                    iconPath = 'icons/weather/day/nuages1.png';
                                    break;
                                  case 'atmosphere':
                                    iconPath = 'icons/weather/day/brouillard1.png';
                                    break;
                                  case 'snow':
                                    iconPath = 'icons/weather/day/neige1.png';
                                    break;
                                  case 'thunderstorm':
                                    iconPath = 'icons/weather/day/orages1.png';
                                    break;
                                  case 'drizzle':
                                  case 'rain':
                                    iconPath = 'icons/weather/day/pluie1.png';
                                    break;
                                  default:
                                    iconPath = 'icons/day/default.png'; // Une icône par défaut si la condition météo n'est pas reconnue
                                }
                                return Image.asset(iconPath, width: 200.0, height: 200.0);
                              }
                            }
                          },
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
        return Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
                itemCount: _cities.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: Border.all(),
                    child: ListTile(
                      title: Text(
                        _cities[index],
                        style: TextStyle(fontSize: 20.0),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              _cities[index] == favoriteCity ? Icons.star : Icons.star_border, // Si la ville est la ville favorite, affichez une étoile pleine. Sinon, affichez une étoile vide.
                            ),
                            onPressed: () {
                              setState(() {
                                favoriteCity = _cities[index]; // Met à jour la ville favorite
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _cities.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: FloatingActionButton(
                onPressed: _addCity,
                child: Icon(Icons.add),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}