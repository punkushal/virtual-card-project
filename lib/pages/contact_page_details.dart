import 'package:flutter/material.dart';

class ContactPageDetails extends StatefulWidget {
  static const String routeName = 'contact';
  final int id;
  const ContactPageDetails({super.key, required this.id});

  @override
  State<ContactPageDetails> createState() => _ContactPageDetailsState();
}

class _ContactPageDetailsState extends State<ContactPageDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
