import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();
  String? _title;
  String? _body;
  String? _img; // no use
  String? userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Note"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Form(
          key: _formState,
          // autovalidateMode: AutovalidateMode.always,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                onSaved: (newValue) => _title = newValue,
                maxLength: 30,
                decoration: InputDecoration(
                  // hintText: "Title",
                  labelText: "Title",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(width: 2.0, color: Colors.red),
                  ),
                ),
              ),
              TextFormField(
                onSaved: (newValue) => _body = newValue,
                maxLines: 3,
                maxLength: 100,
                decoration: InputDecoration(
                  // hintText: "Title",
                  labelText: "Note",
                  prefixIcon: Icon(Icons.note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(width: 2.0, color: Colors.red),
                  ),
                ),
              ),
              ElevatedButton(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Add Image",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                onPressed: () {
                  showBottomSheet();
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Save",
                      style: TextStyle(
                        fontSize: 22.0,
                        // fontWeight: FontWeight.w100,
                      )),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, 'homepage');
                  if (_formState.currentState!.validate()) {
                    _formState.currentState!.save();
                    try {
                      FirebaseFirestore.instance.collection('notes').add({
                        'title': _title,
                        'ownerid': userID,
                        'body': _body,
                        'image': '3.png',
                      });
                      Navigator.pushReplacementNamed(context, 'homepage');
                    } catch (e) {
                      print(e);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Auth Error',
                        desc: '${e}',
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.red,
                      ).show();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  } // end of build ();

  showBottomSheet() {
    double _mdqrWdth = MediaQuery.of(context).size.height;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: _mdqrWdth / 4,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("gallery inkweel");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_album_outlined,
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "From Gallery",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("camera inkweel");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "From Camera",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
