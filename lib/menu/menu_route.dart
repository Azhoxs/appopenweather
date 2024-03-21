import 'package:flutter/material.dart';

import '../routes/home_route.dart';


class MenuRoute extends StatelessWidget {
  const MenuRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Center(
              child: ElevatedButton(

                onPressed: () => _goToHome(context),
                child: const Text("GO"),
              ),
            ),
          ],
        )
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeRoute()));
  }
}