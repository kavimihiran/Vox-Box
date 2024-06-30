import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vox_box/Services/authProvider.dart';
import 'package:vox_box/Views/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase database = FirebaseDatabase(
    databaseURL:
        "https://voxbox-project-default-rtdb.asia-southeast1.firebasedatabase.app",
  );
  FirebaseDatabase.instance
      .setPersistenceEnabled(true); // Optional for offline capabilities
  FirebaseDatabase.instance
      .setPersistenceCacheSizeBytes(10000000); // Optional to set cache size
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignInForm(),
      ),
    );
  }
}
