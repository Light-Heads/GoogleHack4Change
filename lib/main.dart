import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/auth/roles.dart';
import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/theme.dart';
import 'package:frontend/views/auth/login.dart';
import 'package:frontend/views/workers/work_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/controllers/language_controller.dart';
import 'package:get/get.dart';
import 'navigation.dart';
// import 'package:flutter_gen/';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var user = Get.put(UserController());
    Get.put(LocationController());
    Get.put(LanguageController());
    return Obx(() =>
      MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: L10n.all,
          locale: Locale(Get.find<LanguageController>().currentLocale.value),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'Flutter Demo',
          theme: AppTheme.theme,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: user.getUser(snapshot.data!.uid),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                          body: Center(child: CircularProgressIndicator()));
                    }
      
                    if (userSnapshot.hasError) {
                      return const Text("Error fetching user data.");
                    }
      
                    // User data has been successfully fetched.
                    if (user.user.value.role != null) {
                      if (user.user.value.role == 'worker') {
                        return const WorkerScreen();
                      } else {
                        return const Navigation();
                      }
                    } else {
                      return RoleSelectionScreen();
                    }
                  },
                );
              } else {
                return const LoginScreen();
              }
            },
          )),
    );
  }
}
