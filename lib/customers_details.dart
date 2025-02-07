import 'package:flutter/material.dart';

final List<Map<String, dynamic>> customers = [
  {
    "firstName": "PAUL",
    "idNumber": 1300422,
    "lastName": "JONATHAN",
    "phoneNumber": 743098349
  },
  {
    "firstName": "JORAM TONGO BOXER BM 150 KMFT 610G RED ",
    "idNumber": 1944588,
    "lastName": "FROM LWANDETI\\MUTUA BODA LWANDETI STAGE MAIN",
    "phoneNumber": 795196049
  },
  {
    "firstName": "MESHACK SOTSI MUNGALA 0714234652",
    "idNumber": 1945215,
    "lastName": "FROM LWANDETI /MUNIALO MARKET",
    "phoneNumber": 795193290
  },
  {
    "firstName": "RAZZYNAH",
    "idNumber": 1945371,
    "lastName": "KOMBI",
    "phoneNumber": 706234626
  },
  {
    "firstName": "MARY ",
    "idNumber": 1945487,
    "lastName": "SIRENGO",
    "phoneNumber": 792893001
  },
  {
    "firstName": "ALICE NEKESA",
    "idNumber": 6295098,
    "lastName": "THOMSON FROM MKHONJE ASS MUTUPA",
    "phoneNumber": 790081433
  },
  {
    "firstName": "EDSON",
    "idNumber": 6306430,
    "lastName": "KISINDAYI",
    "phoneNumber": 705500371
  },
  {
    "firstName": "REUBEN",
    "idNumber": 6971824,
    "lastName": "MATAYO",
    "phoneNumber": 796045894
  },
  {
    "firstName": "ANDRANO",
    "idNumber": 6988091,
    "lastName": "ATSANGO BODA LUMAMA STAGE LUMAMA  ASS PETER WASIKE",
    "phoneNumber": 748816717
  },
  {
    "firstName": "RUTH NAMACHANJA",
    "idNumber": 7596634,
    "lastName": "WALUCHO  ASS KHAKASA",
    "phoneNumber": 114808872
  },
  {
    "firstName": "ESTHER NECHESA",
    "idNumber": 7598204,
    "lastName": "T MUSAMALI ASS KHAKASA",
    "phoneNumber": 702392751
  },
  {
    "firstName": "WANYONYI",
    "idNumber": 7891616,
    "lastName": "WAfula",
    "phoneNumber": 706907271
  },
  {
    "firstName": "PAUL KILASI WANYAMA HLX 125 KMEA 532U RED",
    "idNumber": 8636460,
    "lastName": "FROM MAYOYO BODA LWANDETI",
    "phoneNumber": 727886987
  },
  {
    "firstName": "CHRISPINUS TOM ANDOBE HLX 125 KMEH 473V BLUE",
    "idNumber": 8714914,
    "lastName": "FROM CHEKALINI BODA STANDIKISA STAGE",
    "phoneNumber": 746880730
  },
  {
    "firstName": "SAKWA NDOLI 0797148320",
    "idNumber": 8836067,
    "lastName": "FROM LWANDETI",
    "phoneNumber": 722112126
  },
  {
    "firstName": "JOICE ALIVIN",
    "idNumber": 9508747,
    "lastName": "WANJALA BODA OFUSA MATURU",
    "phoneNumber": 791928468
  },
  {
    "firstName": "PATRICK BUSOLO",
    "idNumber": 9620675,
    "lastName": "MULATI FROM MAHANGA",
    "phoneNumber": 715190326
  },
];

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
          ),
        )),
      ],
    );
  }
}

class _MapDataTableSource extends DataTableSource {
  final List data;
  final List headers;

  _MapDataTableSource(this.data, this.headers);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];

    final cells = headers
        .map((header) => DataCell(Text(
              row[header]?.toString() ?? '',
              overflow: TextOverflow.ellipsis,
            )))
        .toList();
    return DataRow.byIndex(index: index, cells: cells);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

var CustomersTable = TableData(
  data: customers,
  rowsPerPage: 17,
);
