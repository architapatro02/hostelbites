import 'package:flutter/material.dart';
import 'package:hostelbites/user/NavBar.dart';
import 'package:intl/intl.dart';
import 'NoticeStudent.dart'; // Import your notifications page
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to the notifications page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
        ],
        title: const Text('Home page'),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg9.jpg'), // Replace 'background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 185,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                height: MediaQuery.of(context).size.height - 230,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('menu').doc('latest_menu').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                    }

                    var menuData = snapshot.data!.data() as Map<String, dynamic>?;

                    // Format current day and date
                    String formattedDate = DateFormat('EEEE d MMMM').format(DateTime.now());

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: "Today's Menu",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Colors.brown[900],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Replace the hardcoded breakfast with data from 'menu' collection
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "8:00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.brown[900],
                                    ),
                                  ),
                                  Text(
                                    "AM",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.brown[600],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                width: 1,
                                color: Colors.brown.withOpacity(0.5),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 120,
                                    child: Text(
                                      "  BREAKFAST",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width - 120,
                                        child: Text(
                                          (menuData?['Breakfast'] as String).split(', ').join(', ') ?? '',
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // ... other meal containers
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "12:00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.brown[900],
                                    ),
                                  ),
                                  Text(
                                    "PM",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.brown[600],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                width: 1,
                                color: Colors.brown.withOpacity(0.5),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 120,
                                    child: Text(
                                      "  LUNCH",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width - 120,
                                          child: Text(
                                            (menuData?['Lunch'] as String)?.split(', ')?.join(', ') ?? '',
                                            overflow: TextOverflow.ellipsis,
                                          )
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "8:00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.brown[900],
                                    ),
                                  ),
                                  Text(
                                    "AM",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.brown[600],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                width: 1,
                                color: Colors.brown.withOpacity(0.5),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 120,
                                    child: Text(
                                      "  SNACKS",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width - 120,
                                          child: Text(
                                            (menuData?['Snacks'] as String)?.split(', ')?.join(', ') ?? '',
                                            overflow: TextOverflow.ellipsis,
                                          )
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "8:00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.brown[900],
                                    ),
                                  ),
                                  Text(
                                    "AM",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.brown[600],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                width: 1,
                                color: Colors.brown.withOpacity(0.5),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 120,
                                    child: Text(
                                      "  Dinner",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width - 120,
                                          child: Text(
                                            (menuData?['Dinner'] as String)?.split(', ')?.join(', ') ?? '',
                                            overflow: TextOverflow.ellipsis,
                                          )
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
