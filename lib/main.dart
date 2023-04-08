
import 'package:cattle_guru_agent_app/controllers/phone_number/auth_controller.dart';
import 'package:cattle_guru_agent_app/firebase_options.dart';
import 'package:cattle_guru_agent_app/screens/Details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Home_screen.dart';
import 'package:cattle_guru_agent_app/screens/Navigation_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Order_details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Place_order_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Track_order_screen.dart';
import 'package:cattle_guru_agent_app/screens/Auth/phone_screen.dart';
import 'package:cattle_guru_agent_app/screens/Product_description_page.dart';
import 'package:cattle_guru_agent_app/screens/Products_screen.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_status_tracker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_tracker/order_tracker.dart';

void main() async{ 
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  final authcontroller = Get.lazyPut(()=>AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
    );
  }
}

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        print(snapshot.data.toString());
        print("dkslfsjdkjfjkdf");
        return snapshot.data != null ? NavigationScreen(tabIndex: 0,) : PhoneScreen();
      },
    );
  }
}
