import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();
  String? _name;
  String? _mail;
  String? _psswrd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Image.asset(
              "images/id.jpg",
              height: 300.0,
              width: 300.0,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formState,
              // autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (newValue) {
                      _name = newValue;
                    },
                    validator: (value) {
                      if (value!.length > 25)
                        return 'user name can\'t be larger than 25 letter';
                      else if (value.length < 5)
                        return 'user name can\'t be less than 5 letter';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "User Name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (newValue) {
                      _mail = newValue;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.1),
                      ),
                    ),
                    validator: (email) {
                      if (!EmailValidator.validate(email!))
                        return 'email is not valid';
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (newValue) => _psswrd = newValue,
                    validator: (value) {
                      if (value!.length > 25)
                        return 'passward can\'t be larger than 25 letter';
                      else if (value.length < 5)
                        return 'passward can\'t be less than 2 letter';
                      else
                        return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        var form_data = _formState.currentState;
                        if (form_data!.validate()) {
                          form_data.save();
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _mail!,
                              password: _psswrd!,
                            );
                            //to be cancelled
                            // var userId = credential.user!.uid;
                            // FirebaseFirestore.instance.collection('users').add({
                            //   'userID': userId,
                            //   'username': _name,
                            // });
                            //--------------------------
                            credential.user!.updateDisplayName(_name);
                            if (credential != null)
                              Navigator.pushReplacementNamed(
                                  context, 'homepage');
                          } on FirebaseAuthException catch (e) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Auth Error',
                              desc: '${e.code}',
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                            ).show();
                            // if (e.code == 'weak-password') {
                            //   print('The password provided is too weak.');
                            // } else if (e.code == 'email-already-in-use') {
                            //   print(
                            //       'The account already exists for that email.');
                            // }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("If You Have Account "),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "login");
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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

      // body: Center(
      //   child: Column(
      //     children: [
      //       Container(
      //         width: 200.0,
      //         height: 200.0,
      //         child: Image.asset("./images/ark.jpg"),
      //       ),
      //       Container(
      //         width: 200.0,
      //         height: 200.0,
      //         child: Image(
      //           image: AssetImage("./images/ark.jpg"),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       // ElevatedButton(
      //       //   onPressed: () {
      //       //     print(Navigator.canPop(context));
      //       //     // Navigator.pushNamed(context, "signup");
      //       //     // Navigator.pushReplacementNamed(context, "signup");
      //       //     Navigator.pop(context);
      //       //   },
      //       //   child: Text("back"),
      //       // ),
      //     ],
      //   ),
      // ),