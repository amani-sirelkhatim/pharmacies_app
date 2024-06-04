import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class RequiredPapers extends StatefulWidget {
  const RequiredPapers({
    super.key,
  });

  @override
  State<RequiredPapers> createState() => _RequiredPapersState();
}

class _RequiredPapersState extends State<RequiredPapers> {
  bool arabic = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  arabic = !arabic;
                });
              },
              child: Text(
                arabic ? 'English' : 'Arabic',
                style: getBodyStyle(color: AppColors.primary),
              ))
        ],
      ),
      body: Container(
          child: arabic
              ? SfPdfViewer.asset('assets/docs/arabic.pdf')
              : SfPdfViewer.asset('assets/docs/english.pdf')),
    );
  }
}
