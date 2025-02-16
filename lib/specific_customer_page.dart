import 'package:flutter/material.dart';

class Textfields extends StatefulWidget {
  final TextEditingController controller;
  final String labelName;
  final bool enabled;

  const Textfields(
      {super.key,
      required this.controller,
      required this.labelName,
      required this.enabled});

  @override
  State<Textfields> createState() => _TextfieldsState();
}

class _TextfieldsState extends State<Textfields> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        widget.labelName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Expanded(
        child: TextField(
          controller: widget.controller,
          enabled: widget.enabled,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      )
    ]);
  }
}

class SpecificCustomer extends StatefulWidget {
  final Map<String, dynamic> rowData;

  const SpecificCustomer({
    super.key,
    required this.rowData,
  });

  @override
  State<SpecificCustomer> createState() => _SpecificCustomerState();
}

class _SpecificCustomerState extends State<SpecificCustomer> {
  bool isEditing = false;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _idNumber;
  // late TextEditingController _phoneNumber;
  // late TextEditingController _outstandingDaebt;
  // late TextEditingController _repaymentDate;
  // late TextEditingController _interestRate;

  @override
  void initState() {
    super.initState();
    String firstName = '${widget.rowData['firstName'] ?? ''}';
    String lastName = '${widget.rowData['lastName'] ?? ''}';
    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
    _idNumber = TextEditingController(text: 'id number');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _idNumber.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Row Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Name row: Label and TextField
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Name: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    enabled: isEditing,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                    enabled: isEditing,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Textfields(
              controller: _idNumber,
              enabled: isEditing,
              labelName: 'ID Number: ',
            ),
            const SizedBox(height: 20),
            // Edit/Save button
            ElevatedButton(
              onPressed: toggleEdit,
              child: Text(isEditing ? 'SAVE' : 'Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
