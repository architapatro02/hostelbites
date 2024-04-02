import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteProductPage extends StatefulWidget {
  static const String routeName = '/delete_product';

  @override
  _DeleteProductPageState createState() => _DeleteProductPageState();
}

class _DeleteProductPageState extends State<DeleteProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();

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
            Icon(Icons.delete),
            SizedBox(width: 2),
            Text('Delete Product'), // Changed text to 'Add Product'
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
                  'Please remove the specified product from the inventory !!',
                  style: GoogleFonts.actor(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

              ),
            ),

          ),
          _buildTextField('Enter the ID of the product you want to delete:', _idController),
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
          color: Colors.black,),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.brown[300],
              filled: true,
              hintText: 'Product ID',
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
