import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/styles.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class fullpage extends StatefulWidget {
  const fullpage({super.key, required this.pdf});
  final String pdf;
  @override
  State<fullpage> createState() => _fullpageState();
}

class _fullpageState extends State<fullpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cv',
          style: getTitleStyle(),
        ),
      ),
      body: Container(child: SfPdfViewer.network(widget.pdf)),
    );
  }
}
