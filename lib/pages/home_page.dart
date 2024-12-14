import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card/providers/contact_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  void didChangeDependencies() {
    Provider.of<ContactProvider>(context, listen: false).getAllContactList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactList'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          context.goNamed('scan');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
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
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
            itemCount: provider.allContactList.length,
            itemBuilder: (ctx, index) {
              final contact = provider.allContactList;
              return Dismissible(
                key: UniqueKey(),

                //While swipping showing red color bg with delete icon
                background: Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) => getConfirmation(direction),
                onDismissed: (direction) {
                  provider.deleteContact(contact[index].id);
                },
                child: ListTile(
                  title: Text(contact[index].name),
                  trailing: Icon(contact[index].favorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                ),
              );
            }),
      ),
    );
  }

  Future<bool?> getConfirmation(direction) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Contact'),
        content: const Text('Are you sure to delete this contact?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  context.pop(false);
                },
                child: const Text('No'),
              ),
              const SizedBox(
                width: 8,
              ),
              OutlinedButton(
                onPressed: () {
                  context.pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
