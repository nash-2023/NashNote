/**
(to get SHA1 key)
./gradlew clean build
./gradlew signingReport
  */

  //******************************************** anonymous user */
                // try {
                //   final userCredential =
                //       await FirebaseAuth.instance.signInAnonymously();
                //   print("Signed in with temporary account.");
                //   print(userCredential.user!.uid);
                // } on FirebaseAuthException catch (e) {
                //   switch (e.code) {
                //     case "operation-not-allowed":
                //       print(
                //           "Anonymous auth hasn't been enabled for this project.");
                //       break;
                //     default:
                //       print("Unknown error.");
                //   }
                // }
                //*********************************************anonymous user */
                //********************************************* email-Pswrd */
                // try {
                //   final credential = await FirebaseAuth.instance
                //       .createUserWithEmailAndPassword(
                //     email: 'abdalla.fat7y@hotmail.com',
                //     password: 'asd@asd',
                //   );
                // } on FirebaseAuthException catch (e) {
                //   if (e.code == 'weak-password') {
                //     print('The password provided is too weak.');
                //   } else if (e.code == 'email-already-in-use') {
                //     print('The account already exists for that email.');
                //   }
                // } catch (e) {
                //   print(e);
                // }
                //********************************************* email-Pswrd */
                //********************************************* sign in */
                // try {
                //   final credential =
                //       await FirebaseAuth.instance.signInWithEmailAndPassword(
                //     email: 'abdalla.fat7y@hotmail.com',
                //     password: 'asd@asd',
                //   );

                //   if (!credential.user!.emailVerified) {
                //     User? user = FirebaseAuth.instance.currentUser;
                //     await user!.sendEmailVerification();
                //   }
                // } on FirebaseAuthException catch (e) {
                //   if (e.code == 'user-not-found') {
                //     print('No user found for that email.');
                //   } else if (e.code == 'wrong-password') {
                //     print('Wrong password provided for that user.');
                //   }
                // }

                //********************************************* sign in */

//********************************************************************
//sign in with google 
// 1) for android and jos
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
// 2) for web
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
//********************************************************************