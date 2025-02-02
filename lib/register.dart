import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _kinFirstName = TextEditingController();
  final _kinLastName = TextEditingController();
  final _kinIdNumber = TextEditingController();
  final _kinPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Customer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name:',
                    hintText: 'Enter first name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name:',
                    hintText: 'Enter last name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number:',
                    hintText: 'Enter phone number:',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _idNumberController,
                  decoration: const InputDecoration(
                    labelText: 'ID Number:',
                    hintText: 'Enter ID number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const Text(
                  'Next of Kin Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _kinFirstName,
                  decoration: const InputDecoration(
                    labelText: 'Fisrt Name:',
                    hintText: 'Enter first name',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _kinLastName,
                  decoration: const InputDecoration(
                    labelText: 'Last Name:',
                    hintText: 'Enter last name',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _kinPhoneNumber,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number:',
                    hintText: 'Enter phone number',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _kinIdNumber,
                  decoration: const InputDecoration(
                    labelText: 'ID Number:',
                    hintText: 'Enter Id Number',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_registerFormKey.currentState!.validate()) {
                      Map<String, String> newCustomer = {
                        'firstName': _firstNameController.text,
                        'lastName': _lastNameController.text,
                        'phoneNumber': _phoneNumberController.text,
                        'idNumber': _idNumberController.text,
                      };
                      Map<String, String> KinDetails = {
                        'firstName': _kinFirstName.text,
                        'lastName': _kinLastName.text,
                        'phoneNumber': _kinPhoneNumber.text,
                        'idNumber': _kinIdNumber.text
                      };
                      debugPrint(
                          'customer details is: ${newCustomer.toString()}');
                      _firstNameController.clear();
                      _lastNameController.clear();
                      _phoneNumberController.clear();
                      _idNumberController.clear();
                      _kinFirstName.clear();
                      _kinLastName.clear();
                      _kinPhoneNumber.clear();
                      _kinIdNumber.clear();
                    } else {
                      debugPrint('form not valid');
                    }
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
