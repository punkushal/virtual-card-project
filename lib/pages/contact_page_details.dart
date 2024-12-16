import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:virtual_card/models/contact_model.dart';
import 'package:virtual_card/providers/contact_provider.dart';
import 'package:virtual_card/utils/helper_function.dart';

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
              final contact = snapshot.data;
              return ListView(
                children: [
                  Image.file(
                    File(contact!.imageUrl),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),

                  //For Displaying user's contact info such as mobile number
                  ListTile(
                    leading: Text(
                      contact.mobile,
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            getCall(contact.mobile);
                          },
                          icon: const Icon(Icons.call),
                        ),
                        IconButton(
                          onPressed: () {
                            getSms(contact.mobile);
                          },
                          icon: const Icon(Icons.sms),
                        ),
                      ],
                    ),
                  )
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

  void getCall(String mobile) async {
    final url = 'tel:$mobile';

    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      // ignore: use_build_context_synchronously
      showMsg(context, 'cannot perform this task');
    }
  }

  void getSms(String mobile) async {
    final url = 'sms:$mobile';
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      // ignore: use_build_context_synchronously
      showMsg(context, 'cannot perform this task');
    }
  }
}
