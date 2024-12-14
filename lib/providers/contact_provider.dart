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

  //To delete particular contact by providing it's id
  Future<int> deleteContact(int id) async {
    //We're not refreshing as earlier in above insertContact
    //because we are going to use dissmissle widget
    return db.deleteContact(id);
  }
}
