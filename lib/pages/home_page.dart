import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactList'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.green.shade300,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade300,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}
