import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lol/HomeLayout.dart';

class Splach extends StatefulWidget {
  const Splach({Key? key}) : super(key: key);

  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeLayout()),
          (route) => false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFECF0F3),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  const [
                CircleAvatar(
                  radius: 84,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/AAS.jpg',),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Clinic management',
                    style: TextStyle(color: Colors.black, fontSize: 27)),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
