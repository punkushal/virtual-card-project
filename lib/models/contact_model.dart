class ContactModel {
  int id;
  String name;
  String company;
  String mobile;
  String email;
  String address;
  String imageUrl;
  String designation;
  bool favorite;

  ContactModel({
    this.id = 1,
    required this.name,
    required this.mobile,
    this.address = '',
    this.company = '',
    this.designation = '',
    this.email = '',
    this.imageUrl = '',
    this.favorite = false,
  });
}
