import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:virtual_card/models/contact_model.dart';

class DbHelper {
  final String _createTableContact =
      ''' create table $tblContact($tblCtcColId integer primary key autoincrement,
  $tblCtcColCompany text,
  $tblCtcColName text,
  $tblCtcColAddress text,
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
}
