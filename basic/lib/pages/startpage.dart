import 'package:basic/Uitilities/auth.dart';
import 'package:basic/Uitilities/col.dart';
import 'package:basic/Uitilities/router.dart';
import 'package:basic/pages/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:basic/Uitilities/router.dart';

class Center_page extends StatefulWidget {
  const Center_page({super.key});

  @override
  State<Center_page> createState() => _Center_pageState();
}

class _Center_pageState extends State<Center_page> {
  @override
  DatabaseReference df = FirebaseDatabase.instance.ref().child('User');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: "High Tech ".text.make(),
        ),
        toolbarHeight: 90,
        backgroundColor: rang.always,
      ),
      body: SafeArea(
        child:

           

            Container(
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FirebaseAnimatedList(
                  query: df,
                  shrinkWrap: true,
                  itemBuilder: (context, snapshot, animation, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "  Email :  ${snapshot.child('Email').value.toString()}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "  Name : ${snapshot.child('Name').value.toString()}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text("  Age ${snapshot.child('Age').value.toString()}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text("  Phone ${ snapshot.child('Phone').value.toString()}"),
                        ],
                      ),
                    );
                    
                  }),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        width: 200,
        child: Container(
          child: Column(children: [
            SizedBox(
              height: 125,
              child: Container(
                color: rang.always,
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: "Logout".text.make(),
              onTap: () => {
                Auth().signOut(),
                Navigator.of(context).pushNamedAndRemoveUntil(
                    router.loginroute, (route) => false),
              },
            )
          ]),
        ),
      ),
    );
  }
}
