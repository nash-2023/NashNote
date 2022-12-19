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
  List<Map<String, String>> _notes = [
    {
      'title': "home work",
      'note': "lorem epsum 0",
      'image': 'dog.jpg',
    },
    {
      'title': "home work",
      'note': "lorem epsum 1",
      'image': 'set.jpg',
    },
  ];

  String? getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print('user ID :------------------${user!.uid}');

    return user.email;
  }

  void getData() async {
    ///----------------------------------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((v) => v.docs.forEach((e) => print(e.data())));
    ///--------------------------------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('6s5fg3xts3sfVHNjXymX')
    //     .get()
    //     .then((e) => print(e.data()!['username']));
    ///---------------------------------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('notes')
    //     .where('ownerid', isEqualTo: '6s5fg3xts3sfVHNjXymX')
    //     .get()
    //     .then((v) => v.docs.forEach((e) => print(e.data()['title'])));
    ///-----------------------------------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((v) => v.docs.forEach((e) => print(e.data())));
    ///----------------------Stream--------------------------------------------
    // FirebaseFirestore.instance
    //     .collection('notes')
    //     // .where('owherid', isEqualTo: 'F28cGYZKZXnChxCiqVUq')
    //     .snapshots()
    //     .listen((event) {
    //   event.docs.forEach((element) => print(element.data()));
    // });
    // ----------------------------Add data ------------------------------------
    // FirebaseFirestore.instance.collection('notes').add({
    //           'title': 'Learn#flutter',
    //           'body': 'learn flutter',
    //           'image': '99.jpeg',
    //           'ownerid': 'F28cGYZKZXnChxCiqVUq'
    //         });
    // ----------------------------Edit data (update)------------------------------------
    // FirebaseFirestore.instance
    //     .collection('notes')
    //     .doc('yV8jBnZPSo7F1leNgNj3')
    //     .update({
    //   'title': 'Learn Flutter Framework',
    //   'body': 'Learn to Programming with dart &flutter',
    //   'image': '100.jpeg',
    // });
    //--------------------------------------------------------------------------
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _mdqr = MediaQuery.of(context).size.width;
    String? usr = getUser();
    return Directionality(
      // [ Directionality ] widget for Arabic-English conversion
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: Text('${usr}'),
          title: Text('my home'),
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
        body: Container(
          child: ListView(
            children: List.generate(
              _notes.length,
              (i) {
                /* return Dismissible(
                  key: Key("$i"),
                  child: Row(children: [ 
                    ...the underneith followin code
                    ],
                    ),
                );*/
                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ViewItem(
                        mdqr: _mdqr,
                        note: _notes[i],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {
                          setState(
                            () {
                              _notes.removeAt(i);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            // print("FAB");
            // Navigator.pushNamed(context, 'addnote');
          },
        ),
      ),
    );
  }
}

class ViewItem extends StatelessWidget {
  const ViewItem({Key? key, required this.note, this.mdqr}) : super(key: key);
  final note;
  final mdqr;
  @override
  Widget build(BuildContext context) {
    String img = note['image'];
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
              title: Text(note["title"]),
              subtitle: Text(note["note"]),
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