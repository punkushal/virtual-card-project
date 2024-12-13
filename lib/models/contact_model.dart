//Table Name For The Database
const String tblContact = 'tbl_contact';

//Column Names For The Table
const String tblCtcColName = 'Name';
const String tblCtcColId = 'Id';
const String tblCtcColCompany = 'Company';
const String tblCtcColEmail = 'Email';
const String tblCtcColAddress = 'Address';
const String tblCtcColMobile = 'Mobile';
const String tblCtcColDesignation = 'Designation';
const String tblCtcColFavorite = 'Favorite';
const String tblCtcColWebsite = 'Website';
const String tblCtcColImage = 'Image';

class ContactModel {
  int id;
  String name;
  String company;
  String mobile;
  String email;
  String address;
  String imageUrl;
  String designation;
  String website;
  bool favorite;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.address = '',
    this.company = '',
    this.designation = '',
    this.email = '',
    this.imageUrl = '',
    this.website = '',
    this.favorite = false,
  });

  //Map Value For The Database
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblCtcColName: name,
      tblCtcColCompany: company,
      tblCtcColAddress: address,
      tblCtcColDesignation: designation,
      tblCtcColEmail: email,
      tblCtcColImage: imageUrl,
      tblCtcColWebsite: website,
      tblCtcColMobile: mobile,

      //Sqflite package doesn't support boolean type
      tblCtcColFavorite: favorite ? 1 : 0,
    };

    if (id > 0) {
      map[tblCtcColId] = id;
    }

    return map;
  }

  //To Convert From Map To Contact Model
  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        name: map[tblCtcColName],
        mobile: map[tblCtcColMobile],
        company: map[tblCtcColCompany],
        address: map[tblCtcColAddress],
        email: map[tblCtcColEmail],
        designation: map[tblCtcColDesignation],
        website: map[tblCtcColWebsite],
        imageUrl: map[tblCtcColImage],
        favorite: map[tblCtcColFavorite] == 1 ? true : false,
      );
}
