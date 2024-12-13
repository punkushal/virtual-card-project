import 'package:flutter/foundation.dart';
import 'package:virtual_card/db/db_helper.dart';
import 'package:virtual_card/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> allContactList = [];
  final db = DbHelper();

  //To insert new contact infor to db
  Future<int> insertContact(ContactModel contactModel) {
    return db.insertContact(contactModel);
  }

  //To fetch all the contactlists from db
  Future<void> getAllContactList() async {
    allContactList = await db.getAllContacts();
    notifyListeners();
  }
}
