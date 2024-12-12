import 'package:flutter/material.dart';
import 'package:virtual_card/models/contact_model.dart';
import 'package:virtual_card/utils/constants.dart';
import 'package:virtual_card/widgets/app_txt_form_field.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';
  final ContactModel contactModel;
  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final webController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();

  //Initialized already values from passed contact model
  @override
  void initState() {
    nameController.text = widget.contactModel.name;
    companyController.text = widget.contactModel.company;
    addressController.text = widget.contactModel.address;
    emailController.text = widget.contactModel.email;
    webController.text = widget.contactModel.website;
    mobileController.text = widget.contactModel.mobile;
    designationController.text = widget.contactModel.designation;
    super.initState();
  }

  //To dispose memory space reserved by controllers after formpage state is destroyed
  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    companyController.dispose();
    addressController.dispose();
    designationController.dispose();
    webController.dispose();
    super.dispose();
  }

  onSavingContact() {
    if (_formKey.currentState!.validate()) {
      widget.contactModel.company = companyController.text;
      widget.contactModel.name = nameController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.address = addressController.text;
      widget.contactModel.website = webController.text;
      widget.contactModel.designation = designationController.text;
      widget.contactModel.mobile = mobileController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              //Input Field For Name
              AppTxtFormField(
                vertical: 8,
                horizontal: 12,
                radiusValue: 8,
                labelText: 'Contact Name',
                controller: nameController,
                prefixIcon: const Icon(Icons.person_outline),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return errorMsg;
                  }
                  return null;
                },
              ),

              //Input Field For Company Name
              AppTxtFormField(
                vertical: 8,
                horizontal: 12,
                radiusValue: 8,
                labelText: 'Company Name',
                controller: companyController,
                prefixIcon: const Icon(Icons.badge_outlined),
                validator: (value) {
                  return null;
                },
              ),

              //Input Field For mobile
              AppTxtFormField(
                vertical: 8,
                horizontal: 12,
                radiusValue: 8,
                labelText: 'Contact Number',
                controller: mobileController,
                prefixIcon: const Icon(Icons.phone),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return errorMsg;
                  }
                  return null;
                },
              ),

              //Input Field For email address
              AppTxtFormField(
                vertical: 8,
                horizontal: 12,
                radiusValue: 8,
                labelText: 'Email Address',
                controller: emailController,
                prefixIcon: const Icon(Icons.mail_outline),
                validator: (value) {
                  return null;
                },
              ),

              //Input Field For Designation
              AppTxtFormField(
                vertical: 8,
                horizontal: 12,
                radiusValue: 8,
                labelText: 'Designation',
                controller: designationController,
                prefixIcon: const Icon(Icons.work_outlined),
                validator: (value) {
                  return null;
                },
              ),

              //Input Field For Website
              AppTxtFormField(
                vertical: 8,
                horizontal: 12,
                radiusValue: 8,
                labelText: 'Website',
                controller: webController,
                prefixIcon: const Icon(Icons.web_sharp),
                validator: (value) {
                  return null;
                },
              ),

              //Input Field For Address
              AppTxtFormField(
                vertical: 8,
                horizontal: 12,
                radiusValue: 8,
                labelText: 'Contact Address',
                controller: nameController,
                prefixIcon: const Icon(Icons.location_on),
                validator: (value) {
                  return null;
                },
              ),

              const SizedBox(
                height: 12,
              ),

              //Save Button
              ElevatedButton(
                onPressed: onSavingContact,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(deviceWidth * 0.01, 40),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
