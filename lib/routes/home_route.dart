import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set 'Villes' button as selected
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
              Navigator.pop(context); // Action when 'Météo' button is pressed
              break;
            case 1:
            // Action when 'Villes' button is pressed
              break;
          }
        },
      ),
    );
  }
}