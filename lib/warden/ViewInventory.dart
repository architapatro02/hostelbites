import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewInventoryPage extends StatefulWidget {
  static const String routeName = '/view_product';

  @override
  _ViewInventoryPageState createState() => _ViewInventoryPageState();
}

class _ViewInventoryPageState extends State<ViewInventoryPage> {
  List<Product> products = [
    Product(id: '1', name: 'Product A', quantity: 10, price: 100.0),
    Product(id: '2', name: 'Product B', quantity: 15, price: 150.0),
    Product(id: '3', name: 'Product C', quantity: 20, price: 200.0),
  ];

  List<Product> filteredProducts = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts.addAll(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[500],
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory),
            SizedBox(width: 2),
            Text('View Inventory'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.brown[300],
              ),
              child: Center(
                child: Text(
                  'Please check the inventory for the latest updates !!',
                  style: GoogleFonts.actor(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by Product Name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    filterProducts();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowHeight: 60.0,
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.brown!),
                headingTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Price')),
                ],
                rows: filteredProducts.map((product) {
                  return DataRow(cells: [
                    DataCell(Text(product.id)),
                    DataCell(Text(product.name)),
                    DataCell(Text(product.quantity.toString())),
                    DataCell(Text('\$${product.price.toStringAsFixed(2)}')),
                  ]);
                }).toList(),
                dividerThickness: 2,
                decoration: BoxDecoration(border: Border.all(color: Colors.brown[800]!)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void filterProducts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products.where((product) => product.name.toLowerCase().contains(query)).toList();
    });
  }
}

class Product {
  final String id;
  final String name;
  final int quantity;
  final double price;

  Product({required this.id, required this.name, required this.quantity, required this.price});
}

void main() {
  runApp(MaterialApp(
    home: ViewInventoryPage(),
  ));
}
