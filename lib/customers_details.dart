import 'package:flutter/material.dart';

final List<Map<String, dynamic>> jsonData = [
  {'ID': 1, 'Name': 'John Doe', 'Age': 28, 'Phone': '123-456-7890'},
  {'ID': 2, 'Name': 'Jane Smith', 'Age': 34, 'Phone': '987-654-3210'},
  {'ID': 3, 'Name': 'Sam Wilson', 'Age': 22, 'Phone': '555-123-4567'},
];

class TableData extends StatefulWidget {
  const TableData({super.key});

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  int? _selectedRowIndex;

  void _onRowDoubleClick(Map<String, dynamic> rowData) {
    debugPrint('Clicked row is: $rowData');
  }

  @override
  Widget build(BuildContext context) {
    List<String> headers = jsonData.isNotEmpty ? jsonData[0].keys.toList() : [];

    return Scaffold(
      appBar: AppBar(title: const Text('JSON Data Table')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            columns: headers
                .map((header) => DataColumn(label: Text(header)))
                .toList(),
            rows: jsonData.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> row = entry.value;

              return DataRow(
                color: WidgetStateProperty.resolveWith<Color?>(
                  (states) => _selectedRowIndex == index
                      ? Colors.blue.shade100
                      : (index.isEven ? Colors.grey.shade200 : Colors.white),
                ),
                cells: row.entries
                    .map(
                      (cell) => DataCell(
                        GestureDetector(
                          onDoubleTap: () => _onRowDoubleClick(row),
                          child: Text(cell.value.toString()),
                        ),
                      ),
                    )
                    .toList(),
                onSelectChanged: (isSelected) {
                  setState(() {
                    _selectedRowIndex = isSelected! ? index : null;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: TableData()));
}
