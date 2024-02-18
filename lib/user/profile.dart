import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 50),
            itemProfile('Name', 'Harshita Garg', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemProfile('Email id', 'btbti21071_harshita@bansthali.in', CupertinoIcons.mail_solid),
            const SizedBox(height: 20),
            itemProfile('Hostel Name', 'Shri Shanta Gram', CupertinoIcons.house_fill),
            const SizedBox(height: 20),
            itemProfile('Room no', '76', CupertinoIcons.number_circle),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed:(){},
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.all(15),
                ),
                child:
                const Text('Edit Profile')
            )
          ],
        ),
      ),
    );
  }
  itemProfile(String title,String subtitle,IconData iconData){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow:[
            BoxShadow(
                offset: Offset(0,5),
                color: Colors.brown.withOpacity(1),
                spreadRadius: 4,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle:  Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.edit,color: Colors.black45),
        tileColor: Colors.white,
      ),
    );
  }
}


