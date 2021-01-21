import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  GoogleSignInAccount currentUser;

  Future login() async {
    await googleSignIn.signIn();
  }

  Future signOut() async {
    await googleSignIn.disconnect();
  }

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        currentUser = account;
      });
    });
    googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign In'),
      ),
      body: currentUser == null
          ? Center(
              child: RaisedButton(
                child: Text('Sign In With Google'),
                onPressed: login,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: GoogleUserCircleAvatar(
                      identity: currentUser,
                    ),
                    title: Text(currentUser.displayName),
                    subtitle: Text(currentUser.email),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    onPressed: signOut,
                    child: Text('sign Out'),
                  ),
                ],
              ),
            ),
    );
  }
}
