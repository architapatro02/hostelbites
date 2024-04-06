import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/warden/AddProduct.dart';
import 'package:hostelbites/warden/DeleteProduct.dart';
import 'package:hostelbites/warden/UpdateProduct.dart';
import 'package:hostelbites/warden/ViewInventory.dart';
import 'package:hostelbites/warden/commonBottomNavigation.dart';
import 'package:hostelbites/warden/profile.dart';
import 'package:hostelbites/warden/wardenhome.dart';
import 'package:google_fonts/google_fonts.dart';


class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);
  static const String routeName = '/inventory';

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.brown[900]),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory,
            color: Colors.brown[900],
            ),
            SizedBox(width: 10),
            Text('Inventory',
              style: TextStyle(
                color: Colors.brown[900],
                fontSize: 23,
                fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/images/inven.jpeg'), // Replace 'assets/background_image.jpg' with your image asset path
                fit: BoxFit.cover,
              ),
              color: Colors.brown[300],
            ),
            child: Center(
              // child: Text(
              //   'Update Your Inventory !!',
              //   style: GoogleFonts.actor(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.center,
              // ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBox('Add Product', Icons.add_box_rounded, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage()));
              }),
              _buildBox('Delete Product', Icons.delete, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteProductPage()));
              }),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBox('Update Product', Icons.update_rounded, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProductPage()));
              }),
              _buildBox('View Inventory', Icons.inventory_2, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewInventoryPage()));
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CommonBottomNavigationBar(
        onTabTapped: (index) {
          // Handle bottom navigation item taps
          if (index == 0) {
            // Handle Home page navigation
            // You can replace the current page with the home page or any other logic you prefer
            // Profile Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WardenHome()),
            );
          } else if (index == 1) {
            // Handle Inventory page navigation
            // No action needed as we are already on the Inventory page
          } else if (index == 2) {
            // Handle Profile page navigation
            // Navigate to the Profile page
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
          }
        },
        currentIndex: 1, // Set the current index to 1 for Inventory
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: signOut,
        tooltip: 'Log OUT',
        child: const Icon(Icons.exit_to_app_sharp),
        backgroundColor: Colors.brown,
      ),
    );
  }

  Widget _buildBox(String title, IconData icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.brown[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 50,color: Colors.brown[900],),
            Text(
              title,
              style: GoogleFonts.actor(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
