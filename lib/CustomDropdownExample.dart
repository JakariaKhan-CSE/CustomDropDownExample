import 'package:basic_custom_dropdown/CustomMultiSelectDropdown.dart';
import 'package:basic_custom_dropdown/drop_down_item.dart';
import 'package:flutter/material.dart';

class CustomDropDownExample extends StatefulWidget {
  const CustomDropDownExample({super.key});

  @override
  State<CustomDropDownExample> createState() => _CustomDropDownExampleState();
}

class _CustomDropDownExampleState extends State<CustomDropDownExample> {
  List<String> selectedFruits = [];
  List<String> selectedColors = [];

  final List<DropdownItem<String>> fruits = [
    DropdownItem(value: 'apple', label: 'Apple'),
    DropdownItem(value: 'banana', label: 'Banana'),
    DropdownItem(value: 'orange', label: 'Orange'),
    DropdownItem(value: 'mango', label: 'Mango'),
    DropdownItem(value: 'apple', label: 'Apple'),
    DropdownItem(value: 'banana', label: 'Banana'),
    DropdownItem(value: 'orange', label: 'Orange'),
    DropdownItem(value: 'mango', label: 'Mango'),
    DropdownItem(value: 'apple', label: 'Apple'),
    DropdownItem(value: 'banana', label: 'Banana'),
    DropdownItem(value: 'orange', label: 'Orange'),
    DropdownItem(value: 'mango', label: 'Mango'),
  ];

  final List<DropdownItem<String>> colors = [
    DropdownItem(value: 'red', label: "Red"),
    DropdownItem(value: 'blue', label: 'Blue'),
    DropdownItem(value: 'green', label: 'Green'),
    DropdownItem(value: 'yellow', label: 'Yellow'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Dropdown Example')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Fruits:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomMultiSelectDropdown(
              items: fruits,
              selectedValues: selectedFruits,
              onChanged: (value) {
                setState(() {
                  selectedFruits = value;
                });
              },
              hintText: 'Choose fruits...',
            ),
            const SizedBox(height: 24),

            Text(
              'Select Colors:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomMultiSelectDropdown(
              items: colors,
              selectedValues: selectedColors,
              onChanged: (value) {
                setState(() {
                  selectedColors = value;
                });
              },
              hintText: 'Choose colors...',
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                print('Selected fruits: $selectedFruits');
                print('Selected colors: $selectedColors');
              },
              child: const Text('Show Selected Values'),
            ),

          ],
        ),
      ),
    );
  }
}
