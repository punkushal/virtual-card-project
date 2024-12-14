import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:virtual_card/models/contact_model.dart';

class DbHelper {
  final String _createTableContact =
      ''' create table $tblContact($tblCtcColId integer primary key autoincrement,
  $tblCtcColCompany text,
  $tblCtcColName text,
  $tblCtcColAddress text,
  $tblCtcColMobile text,
  $tblCtcColEmail text,
  $tblCtcColDesignation text,
  $tblCtcColWebsite text,
  $tblCtcColImage text,
  $tblCtcColFavorite integer)
''';
  Future<Database> _open() async {
    //Get the path for root directory
    final root = await getDatabasesPath();

    //Our newly created db file path
    final dbPath = p.join(root, 'contact.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        //When we first time call this _open function then inside onCreate(),our database will be created for the first time
        //and after that whenever we again call _open(), then it simply use the already created db table
        db.execute(_createTableContact);
      },
    );
  }

  //While inserting contact in the database it will return id value
  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    final id = await db.insert(
      tblContact,
      contactModel.toMap(),
    );
    return id;
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tblContact);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }

  Future<List<ContactModel>> getAllFavoriteContacts() async {
    final db = await _open();
    final mapList = await db
        .query(tblContact, where: '$tblCtcColFavorite = ? ', whereArgs: [1]);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }

  //To deleted contact from the database
  Future<int> deleteContact(int id) async {
    final db = await _open();
    return db.delete(tblContact, where: '$tblCtcColId = ? ', whereArgs: [id]);
  }

  //To update contact field
  Future<int> updateFavorite(int id, int value) async {
    final db = await _open();
    return await db.update(tblContact, {tblCtcColFavorite: value},
        where: '$tblCtcColId = ? ', whereArgs: [id]);
  }
}
