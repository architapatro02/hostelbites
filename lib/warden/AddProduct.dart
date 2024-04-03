import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add_product';

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedQuantityUnit = 'kg';
  String _selectedPriceUnit = 'per kg';
  List<String> _quantityUnits = ['kg', 'ltr', 'piece'];
  List<String> _priceUnits = ['per kg', 'per ltr', 'per piece'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[500],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 20), // Increased space
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'Product ID',
                    labelStyle: TextStyle(color: Colors.brown[500]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[500]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[500]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Colors.brown[500]),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Product ID';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: TextStyle(color: Colors.brown[500]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[500]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[500]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Colors.brown[500]),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Product Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: TextStyle(color: Colors.brown[500]),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown[500]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown[500]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(color: Colors.brown[500]),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _selectedQuantityUnit,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedQuantityUnit = newValue!;
                          _selectedPriceUnit = 'per $newValue';
                        });
                      },
                      items: _quantityUnits.map<DropdownMenuItem<String>>((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit, style: TextStyle(color: Colors.brown[500])),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(color: Colors.brown[500]),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown[500]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown[500]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(color: Colors.brown[500]),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Price';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      _selectedPriceUnit,
                      style: TextStyle(color: Colors.brown[500]),
                    ),
                  ],
                ),
                SizedBox(height: 40), // Increased space
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _checkProductId();
                      }
                    },
                    child: Text('Add Product'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[500],
                      textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
              ' "Add Products" ',
              style: GoogleFonts.actor(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _checkProductId() {
    String lowercaseProductId = _idController.text.toLowerCase();
    FirebaseFirestore.instance.collection('productIds').doc(lowercaseProductId).get().then((docSnapshot) {
      if (docSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product ID already exists', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red, // Set snack bar background color here
          ),
        );
      } else {
        _addProduct(lowercaseProductId);
      }
    }).catchError((error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check product ID: $error', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red, // Set snack bar background color here
        ),
      );
    });
  }

  void _addProduct(String lowercaseProductId) {
    FirebaseFirestore.instance.collection('inventory').doc(lowercaseProductId).get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Product ID already exists, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product ID already exists', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red, // Set snack bar background color here
          ),
        );
      } else {
        // Product ID does not exist, add the product
        FirebaseFirestore.instance.collection('inventory').doc(lowercaseProductId).set({
          'productId': _idController.text,
          'productName': _nameController.text,
          'quantity': '${_quantityController.text} $_selectedQuantityUnit',
          'price': '${_priceController.text} $_selectedPriceUnit',
        }).then((value) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Product added successfully', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green, // Set snack bar background color here
            ),
          );
          // Clear form fields
          _idController.clear();
          _nameController.clear();
          _quantityController.clear();
          _priceController.clear();
          setState(() {
            _selectedQuantityUnit = 'kg';
            _selectedPriceUnit = 'per kg';
          });
        }).catchError((error) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add product: $error', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red, // Set snack bar background color here
            ),
          );
        });
      }
    }).catchError((error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check product ID: $error', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red, // Set snack bar background color here
        ),
      );
    });
  }

}
