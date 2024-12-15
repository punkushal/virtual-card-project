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

  //To fetch a contact by its id from db
  Future<ContactModel> getContactById(int id) async {
    final contact = await db.getContactById(id);
    return contact;
  }

  //To fetch all the contactlists from db
  Future<void> getAllFavoriteContactList() async {
    allContactList = await db.getAllFavoriteContacts();
    notifyListeners();
  }

  //To delete particular contact by providing it's id
  Future<int> deleteContact(int id) async {
    //We're not refreshing as earlier in above insertContact
    //because we are going to use dissmissle widget
    return db.deleteContact(id);
  }

  //To update contact as favorite or not
  Future<void> updateFavoriteContact(ContactModel contactModel) async {
    //toggeling between value in favorite column field
    final value = contactModel.favorite ? 0 : 1;
    db.updateFavorite(contactModel.id, value);
    final index = allContactList.indexOf(contactModel);
    allContactList[index].favorite = !allContactList[index].favorite;
    notifyListeners();
  }
}
