import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_options.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<EmailAuthProvider> providers = [EmailAuthProvider()];
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),

      // initialRoute:
      //     FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
      // routes: {
      //   '/sign-in': (context) {
      //     return SignInScreen(
      //       providers: providers,
      //       actions: [
      //         AuthStateChangeAction<SignedIn>((context, state) {
      //           Navigator.pushReplacementNamed(context, '/profile');
      //         }),
      //       ],
      //     );
      //   },
      //   '/profile': (context) {
      //     return ProfileScreen(
      //       providers: providers,
      //       actions: [
      //         SignedOutAction((context) {
      //           Navigator.pushReplacementNamed(context, '/sign-in');
      //         }),
      //       ],
      //     );
      //   },
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? file;
  var imagepicker = ImagePicker();
  void uploadImage() async {
    var imgPicked = await imagepicker.getImage(source: ImageSource.gallery);
    if (imgPicked != null) {
      // file = File(imgPicked.path);
      print(imgPicked.path);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                //***************
                uploadImage();
                //****************
              },
              child: Text("upload image"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('floating action button');
        },
        tooltip: 'do sth',
        child: const Icon(Icons.quiz_sharp),
      ),
    );
  }
}



  // Future<UserCredential> signIn2WithGoogle() async {
  //   // for Android & IOS
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // Future<UserCredential> signInWithGoogle() async {
  //   // For Web
  //   // Create a new provider
  //   GoogleAuthProvider googleProvider = GoogleAuthProvider();

  //   googleProvider
  //       .addScope('https://www.googleapis.com/auth/contacts.readonly');
  //   googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithPopup(googleProvider);

  //   // Or use signInWithRedirect
  //   // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  // }
