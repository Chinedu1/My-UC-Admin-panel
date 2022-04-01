import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uc_trans_web_portal/config.dart';
import 'package:uc_trans_web_portal/main_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  String adminemail = "";
  String adminpassword = "";

  allowAdminToLogin() async
  {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking... ",
        style:  TextStyle(
          fontSize: 36,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.pinkAccent,
      duration:  Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: adminemail,
        password: adminpassword,
    ).then((fAuth)
    {
      // success
      currentAdmin = fAuth.user;
    firebaseUserid = currentAdmin!.uid;
    }).catchError((onError)
    {
      // In case of error
      //display error message

      final snackBar = SnackBar(
        content: Text(
          "Error Occurred: " + onError.toString(),
          style: const TextStyle(
            fontSize: 36,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    });

    if(currentAdmin != null)
    {
      //check if that admin record exists in the admin
      currentAdmin = currentAdmin;
      Fluttertoast.showToast(msg: "Login Successful.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //image
                  Image.asset(
                    "images/admin.png"

                  ),

                  //email text field
                  TextField(
                    onChanged: (value)
                    {
                      adminemail = value;

                    },
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2,

                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan,
                          width: 2,

                        ),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.email,
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10,),

                  //password text field
                  TextField(
                    onChanged: (value)
                    {
                      adminpassword = value;
                    },
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2,

                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan,
                          width: 2,

                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.cyan,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),
                  
                  //button login
                  ElevatedButton(
                    onPressed: ()
                    {
                      allowAdminToLogin();
                      
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),

                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
