import 'package:flutter/material.dart';
import 'package:pharmacies_app/features/user/home/widgets/cattogories.dart';
import 'package:pharmacies_app/features/user/home/widgets/header.dart';
import 'package:pharmacies_app/features/user/home/widgets/pharmaciesList.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [Header(), PharmaciesList(), Cattegories()],
          ),
        ),
      ),
    );
  }
}
