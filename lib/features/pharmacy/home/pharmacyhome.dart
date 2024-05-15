import 'package:flutter/material.dart';
import 'package:pharmacies_app/features/pharmacy/home/widgets/cat.dart';

import 'package:pharmacies_app/features/pharmacy/home/widgets/pharmayHeader.dart';

class PharmacyHome extends StatefulWidget {
  const PharmacyHome({super.key});

  @override
  State<PharmacyHome> createState() => _PharmacyHomeState();
}

class _PharmacyHomeState extends State<PharmacyHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [PharmacyHeader(), PharmacyCate()],
          ),
        ),
      ),
    );
  }
}
