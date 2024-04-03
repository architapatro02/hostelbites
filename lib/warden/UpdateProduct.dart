import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateProductPage extends StatefulWidget {
  static const String routeName = '/update_product';

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _idController = TextEditingController();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  bool _isLoading = false;
  bool _showFields = false;
  bool _isEditing = false;

  Widget _buildHeader() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 50,
            child: Text(
              ' "Update any Product" ',
              style: GoogleFonts.actor(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
        backgroundColor: Colors.brown[500],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20,),
            TextFormField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Product ID',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 2.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product ID';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchProductDetails();
              },
              child: Text('Fetch Product Details'),
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
              ),
            ),
            SizedBox(height: 20),
            if (_showFields)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.brown[50],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField('Product Name', _productNameController),
                        SizedBox(height: 20),
                        _buildTextField('Price', _priceController),
                        SizedBox(height: 20),
                        _buildTextField('Quantity', _quantityController),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _updateProduct,
                          child: Text('Update Product'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit button press
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.brown, width: 2.0),
        ),
      ),
      readOnly: !_isEditing,
    );
  }

  void _updateProduct() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Update'),
        content: Text('Are you sure you want to update the product?'),
        actions: [
          TextButton(
            onPressed: () {
              // Perform the update operation here
              String productId = _idController.text.toLowerCase();
              FirebaseFirestore.instance.collection('inventory').doc(productId).update({
                'productName': _productNameController.text,
                'price': _priceController.text,
                'quantity': _quantityController.text,
              }).then((value) {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              }).catchError((error) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to update product: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  void _fetchProductDetails() {
    setState(() {
      _isLoading = true;
      _showFields = false; // Hide fields until details are fetched
    });

    String productId = _idController.text.toLowerCase();
    FirebaseFirestore.instance.collection('inventory').doc(productId).get().then((docSnapshot) {
      setState(() {
        _isLoading = false;
      });

      if (docSnapshot.exists) {
        setState(() {
          _showFields = true;
          _productNameController.text = docSnapshot['productName'];
          _priceController.text = docSnapshot['price'] != null ? docSnapshot['price'].toString() : '';
          _quantityController.text = docSnapshot['quantity'] != null ? docSnapshot['quantity'].toString() : '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product ID does not exist')),
        );
      }
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _productNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
