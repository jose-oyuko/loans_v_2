import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var baseUrl = dotenv.env['BASE_URL'];

class TableData extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int rowsPerPage;

  const TableData({
    super.key,
    required this.data,
    this.rowsPerPage = 5,
  });

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  late List<Map<String, dynamic>> filteredData;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredData = widget.data;
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredData = widget.data;
      } else {
        filteredData = widget.data.where((row) {
          return row.values.any((value) =>
              value.toString().toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(
        child: Text('No data available'),
      );
    }

    final headers = widget.data.first.keys.toList();
    final columns =
        headers.map((header) => DataColumn(label: Text(header))).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: updateSearch,
            decoration: const InputDecoration(
              labelText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: PaginatedDataTable(
              header: const Text("Data Table"),
              columns: columns,
              source: _MapDataTableSource(filteredData, headers),
              rowsPerPage: widget.rowsPerPage,
              showCheckboxColumn: false,
            ),
          ),
        ),
      ],
    );
  }
}

class _MapDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final List<String> headers;
  int? _selectedRowIndex;

  _MapDataTableSource(this.data, this.headers);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];

    final cells = headers
        .map(
          (header) => DataCell(
            InkWell(
              onDoubleTap: () {
                debugPrint('Row $index data: ${row.toString()}');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  row[header]?.toString() ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        )
        .toList();
    return DataRow.byIndex(
      index: index,
      selected: index == _selectedRowIndex,
      onSelectChanged: (bool? selected) {
        if (selected == true) {
          _selectedRowIndex = index;
        } else {
          _selectedRowIndex = null;
        }

        notifyListeners();
      },
      cells: cells,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

// fetching remote data

// function fetching the remote data
Future<List<Map<String, dynamic>>> fetchRemoteData(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    // convert to Map<String, dyanamic>
    return jsonData.map((item) => item as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to load data from');
  }
}

// widget that uses the remote data
class RemoteTableData extends StatelessWidget {
  final String dataUrl;
  final int rowsPerPage;

  const RemoteTableData({
    super.key,
    required this.dataUrl,
    this.rowsPerPage = 5,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchRemoteData(dataUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Data availabke'));
        } else {
          // passing it to the table widget now when ready
          return TableData(
            data: snapshot.data!,
            rowsPerPage: rowsPerPage,
          );
        }
      },
    );
  }
}

final String customerUrl = '$baseUrl/allCustomers';

var CustomersTable = RemoteTableData(
  dataUrl: customerUrl,
  rowsPerPage: 50,
);
