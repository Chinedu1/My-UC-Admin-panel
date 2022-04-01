import 'package:firebase/firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../config.dart';


class AllVerifiedUsersScreen extends StatefulWidget {
  const AllVerifiedUsersScreen({Key? key}) : super(key: key);

  @override
  _AllVerifiedUsersScreenState createState() => _AllVerifiedUsersScreenState();
}

class _AllVerifiedUsersScreenState extends State<AllVerifiedUsersScreen>
{

  showData(){}



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseDatabase.instance.ref().child("drivers")
    // .get(firebaseUser.uid).then((snapshot){print(snapshot.value);});
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
    userRef.child(firebaseUserid).child('name').once().then((DatabaseEvent event) {
      DataSnapshot snap = event.snapshot;

      print(snap.value);

    });



  }


  @override

  Widget build(BuildContext context)
  {

    return const Scaffold(


      );
  }
}
