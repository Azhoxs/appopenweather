import 'package:flutter/material.dart';

import '../routes/home_route.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
          switch (index) {
            case 0:
            // Action when 'Météo' button is pressed
              break;
            case 1:
              _goToHome(context); // Action when 'Villes' button is pressed
              break;
          }
        },
      ),
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeRoute()));
  }
}