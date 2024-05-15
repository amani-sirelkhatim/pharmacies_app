import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pharmacies_app/features/Auth/Cupit/AuthCupit.dart';
import 'package:pharmacies_app/features/pharmacy/add%20drug/Cupit/AddDrugCupit.dart';
import 'package:pharmacies_app/features/splash.dart';
import 'package:pharmacies_app/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDwyhzgS98z2_6KxpN5LTfrcKB72Lr5ess",
          appId: "com.example.pharmacies_app",
          messagingSenderId: "357529201206",
          projectId: "pharmacy-1a87c"));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => AddDrugCubit(),
          ),
        ],
        child: MaterialApp(
            locale: const Locale('ar'),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: splash()),
      ),
    );
  }
}
