import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card/models/contact_model.dart';
import 'package:virtual_card/providers/contact_provider.dart';

class ContactPageDetails extends StatefulWidget {
  static const String routeName = 'contact';
  final int id;
  const ContactPageDetails({super.key, required this.id});

  @override
  State<ContactPageDetails> createState() => _ContactPageDetailsState();
}

class _ContactPageDetailsState extends State<ContactPageDetails> {
  late int id;

  @override
  void initState() {
    id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Page Details'),
        centerTitle: true,
      ),
      body: Consumer<ContactProvider>(builder: (context, provider, child) {
        return FutureBuilder<ContactModel>(
          future: provider.getContactById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Image.file(
                    File(snapshot.data!.imageUrl),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error While Loading'),
              );
            }
            return const Center(child: Text('Please wait.....'));
          },
        );
      }),
    );
  }
}
