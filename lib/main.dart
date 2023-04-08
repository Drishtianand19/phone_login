import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phonelogin/provider/auth_provider.dart';
import 'package:phonelogin/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp ( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_)=>AuthProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        title: "FlutterAuthPhone",
      ),
    );
  }
}

