import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add_prodAuct';

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  bool isSubmitting = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[500],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_box_rounded),
            SizedBox(width: 2),
            Text('Add product'),
          ],
        ),
      ),
      body: ListView(
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
                  'Add New Product to Your Inventory !!',
                  style: GoogleFonts.actor(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

              ),
            ),

          ),
          SizedBox(height: 30),
          _buildTextField('PRODUCT ID', _idController),
          _buildTextField('PRODUCT NAME', _nameController),
          _buildTextField('QUANTITY', _quantityController),
          _buildTextField('PRICE', _priceController),
          SizedBox(height: 20),
          SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     // Add logic to save product
          //   },
          //   child: Text('Save Product'),
          // ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.actor(
            fontSize: 20,
            fontWeight: FontWeight.bold, // Change font weight if needed
            color: Colors.black,
          ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            style: GoogleFonts.actor(
              fontSize: 18, // Change font size if needed
              color: Colors.black, // Change text color
            ),
            decoration: InputDecoration(
              fillColor: Colors.brown[300],
              filled: true,
              hintText: 'Please enter ${label.toLowerCase()}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

