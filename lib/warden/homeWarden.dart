import 'package:flutter/material.dart';
import 'package:hostelbites/warden/NavBar.dart';

class WardenHome extends StatefulWidget {
  const WardenHome({super.key});

  @override
  State<WardenHome> createState() => _WardenHomeState();
}

class _WardenHomeState extends State<WardenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Home page'),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
    );
  }
}
