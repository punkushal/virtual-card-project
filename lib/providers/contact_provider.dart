import 'package:flutter/foundation.dart';
import 'package:virtual_card/db/db_helper.dart';
import 'package:virtual_card/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> allContactList = [];
  final db = DbHelper();

  //To insert new contact infor to db
  Future<int> insertContact(ContactModel contactModel) async {
    final rowId = await db.insertContact(contactModel);
    contactModel.id = rowId;
    allContactList.insert(0, contactModel);
    notifyListeners();
    return rowId;
  }

  //To fetch all the contactlists from db
  Future<void> getAllContactList() async {
    allContactList = await db.getAllContacts();
    notifyListeners();
  }
}
