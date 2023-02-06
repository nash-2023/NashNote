import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userID;
  String? usrNm;
  String? usrMail;
  // List<QueryDocumentSnapshot<Map<String, dynamic>>> notes = []; //-23
  void getUser() async {
    var user = FirebaseAuth.instance.currentUser;
    userID = user!.uid;
    usrMail = user.email;
    usrNm = user.displayName;
    setState(() {});
  }

  // trials() async {
  //-------for future builder
  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    //----------------------------------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((v) => v.docs.forEach((e) => print(e.data())));
    //--------------------------------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('6s5fg3xts3sfVHNjXymX')
    //     .get()
    //     .then((e) => print(e.data()!['username']));
    //---------------------------------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((v) => v.docs.forEach((e) => print(e.data())));
    //----------------------for Stream subscription----------------------
    // FirebaseFirestore.instance
    //     .collection('notes')
    //     .snapshots()
    //     .listen((event) => event.docs.forEach((element) {
    //           print(element.data()['title']);
    //         }));
    // ----------------------------{{ Add Note }} --------------
    // FirebaseFirestore.instance.collection('notes').add({
    //   'title': 'Abdalla 4Do',
    //   'body': 'Work flutter',
    //   'image': '105.jpeg',
    //   'ownerid': userID,
    // });
    // ----------------------------Edit data (update)----------------
    // FirebaseFirestore.instance
    //     .collection('notes')
    //     .doc('yV8jBnZPSo7F1leNgNj3')
    //     .update({
    //   'title': 'Learn Flutter Framework',
    //   'body': 'Learn to Programming with dart &flutter',
    //   'image': '100.jpeg',
    // });
    //----------------------------------------------for future builder---
    var v = await FirebaseFirestore.instance
        .collection('notes')
        .where('ownerid', isEqualTo: userID)
        .get();
    return v;
    // -------------------ep 21 transaction
    // final DocumentReference<Map<String, dynamic>> userDoc = FirebaseFirestore
    //     .instance
    //     .collection('users')
    //     .doc('6s5fg3xts3sfVHNjXymX');
    // FirebaseFirestore.instance.runTransaction((transaction) async {
    //   final DocumentSnapshot<Map<String, dynamic>> docSnap =
    //       await transaction.get(userDoc);
    //   if (docSnap.exists) {
    //     print('exist');
    //     transaction.update(userDoc, {
    //       'phone': '01129116666',
    //     });
    //   } else {
    //     print('notexist');
    //   }
    // });
    // -------------------------- 22 Batch Write ----------------------------
    //   final DocumentReference<Map<String, dynamic>> emanDoc = FirebaseFirestore
    //     .instance
    //     .collection('users')
    //     .doc('6s5fg3xts3sfVHNjXymX');
    // final DocumentReference<Map<String, dynamic>> newDoc = FirebaseFirestore
    //     .instance
    //     .collection('users')
    //     .doc('kDDsRygUz9VvI7dpf9Dh');
    // WriteBatch batch = FirebaseFirestore.instance.batch();
    // batch.delete(newDoc);
    // batch.update(emanDoc, {'phone': '011125252525'});
    // batch.commit();
    //----------------------------23 show data in ui
    // var x = await FirebaseFirestore.instance.collection('notes').get();
    // x.docs.forEach((element) {
    //   // print(element.data()['username']);
    //   notes.add(element);
    // });
    // // print(notes);
    // setState(() {});
  }

  @override
  void initState() {
    getUser();
    // trials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // [ Directionality ] widget for Arabic-English conversion
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          // leading: Text('${usr}'),
          title: Text('my home'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.red,
                ),
                accountName: Text("${usrNm}"),
                accountEmail: Text("${usrMail}"),
              ),
            ],
          ),
        ),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('notes')
                .where('ownerid', isEqualTo: userID)
                .snapshots(),
            builder: (context, snapshot) {
              Widget render;
              if (snapshot.hasData) {
                var fnotes = snapshot.data!.docs;
                render = ListView(
                  children: List.generate(
                    // _notes.length,
                    fnotes.length,
                    (i) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ViewItem(
                              note: fnotes[i],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.delete_forever),
                              onPressed: () {
                                setState(
                                  () {
                                    var noteID = fnotes[i].id;
                                    print('${fnotes[i].id}');
                                    FirebaseFirestore.instance
                                        .collection('notes')
                                        .doc(noteID)
                                        .delete();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                render = Text("eror${snapshot.error}");
              } else {
                render = CircularProgressIndicator();
              }
              return render;
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, 'addnote');
          },
        ),
      ),
    );
  }
}

class ViewItem extends StatelessWidget {
  const ViewItem({Key? key, required this.note}) : super(key: key);
  final note;

  @override
  Widget build(BuildContext context) {
    String img = note.data()['image'];
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "images/$img",
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListTile(
              title: Text(note.data()["title"]),
              subtitle: Text(note.data()["body"]),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//-------- simple approach
/*
ListView(
          children: (notes.isEmpty)
              ? [
                  CircularProgressIndicator(),
                ]
              : [
                  for (var i in notes)
                    ViewItem(
                      note: i,
                    )
                ],
        ),
*/
//-------- Future Builder
/*
FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              Widget render;
              if (snapshot.hasData) {
                var fnotes = snapshot.data!.docs;
                render = ListView(
                  children: List.generate(
                    // _notes.length,
                    fnotes.length,
                    (i) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ViewItem(
                              note: fnotes[i],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.delete_forever),
                              onPressed: () {
                                setState(
                                  () {
                                    // _notes.removeAt(i);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                render = Text("eror${snapshot.error}");
              } else {
                render = CircularProgressIndicator();
              }
              return render;
            },
          ),
*/
//------- Stream Builder
/*

*/    
//-----------------------

/*
**
*/
// // If you wanna make it in the _HomePageState >> build( * );
// // It will be as following
// ListTile(
//               leading: Image.asset(
//                 "./images/$img",
//                 width: 35.0,
//                 height: 35.0,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(_notes[i]["title"]),
//               subtitle: Text(_notes[i]['note']),
//             );
/***********
 * 
 * 
 *  Card(
      child: Row(
        children: [
          Container(
            width: mdqr - 110, // first way  in [Container widget]
            // the other way by use [Expanded widget]
            child: ListTile(
              title: Text(note["note"]),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            width: 100.0,
            child: Image.asset(
              "./images/$img",
              width: 35.0,
              height: 35.0,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  } 

  */
