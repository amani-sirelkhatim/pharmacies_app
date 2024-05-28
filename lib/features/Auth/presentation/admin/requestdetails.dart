import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/Auth/presentation/admin/pdf.dart';
import 'package:pharmacies_app/generated/l10n.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Req extends StatefulWidget {
  const Req(
      {super.key,
      required this.id,
      required this.email,
      required this.pdf,
      required this.name,
      required this.status});
  final String id;
  final String email;
  final String name;
  final String pdf;
  final String status;
  @override
  State<Req> createState() => _ReqState();
}

class _ReqState extends State<Req> {
  Future<void> send(int type, String pharmacyname, String pharmacyemail) async {
    late String body;
    late String subject;

    if (type == 1) {
      subject = 'Welcome to MediQuick Your Pharmacy Has Been Accepted!';
      body = '''
Dear $pharmacyname Team,

    We are excited to inform you that your pharmacy has been accepted to join MediQuick Our team was impressed by your commitment to providing excellent service and high-quality products, and we believe your pharmacy will be a valuable addition to our platform.

    **What’s Next?**

    1-Complete your signupprocess.
    2-Add your products for the customers to view them.

   

    We are thrilled to have you on board and look forward to a successful partnership. Should you have any questions or need assistance, please don’t hesitate to contact our support team at MediQuick@gmail.com.

    Welcome to the MediQuick family!

    Best regards,

   
''';
    } else {
      subject = 'Important: Your Pharmacy Application for MediQuick';
      body = '''
Dear $pharmacyname Team,

    Thank you for your interest in joining MediQuick. After reviewing your application, we regret to inform you that we cannot accept your pharmacy at this time due to missing health documents or papers required for verification.

    **What You Need to Do:**

    1. **Submit Required Documents**: Please ensure that you submit all the necessary health documents and papers to meet our verification standards. This includes:
       - [List of required documents]
       - [Any other specific requirements]

    2. **Resubmit Your Application**: Once you have gathered all the required documents, you can resubmit your application through our portal at [resubmission URL].

    If you have any questions or need assistance with the submission process, please do not hesitate to contact our support team at MediQuick@gmail.com .

    We value your interest in partnering with us and hope to welcome your pharmacy to MediQuick in the near future.

    Best regards,

''';
    }
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [pharmacyemail],
      // attachmentPaths: attachments,
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Request Details',
          style: getTitleStyle(color: AppColors.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_pharmacy,
                  color: AppColors.primary,
                ),
                const Gap(20),
                Text(
                  widget.name,
                  style: getBodyStyle(),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: AppColors.primary,
                ),
                const Gap(20),
                Text(
                  widget.email,
                  style: getBodyStyle(),
                ),
              ],
            ),
            Gap(20),
            GestureDetector(
              child: Container(
                  padding: EdgeInsets.all(1),
                  height: 150,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SfPdfViewer.network(
                      widget.pdf,
                      onDocumentLoaded: (details) {
                        print("PDF Loaded");
                      },
                      onDocumentLoadFailed: (details) {
                        print("Failed to load PDF: ${details}");
                      },
                    ),
                  )),
            ),
            Gap(10),
            CustomButton(
              style: getSmallStyle(
                  color: AppColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
              text: 'Full Page View',
              bgcolor: AppColors.primary,
              onTap: () {
                push(
                    context,
                    fullpage(
                      pdf: widget.pdf,
                    ));
              },
            ),
            Gap(40),
            widget.status == 'pending'
                ? Container(
                    padding: const EdgeInsets.all(10),
                    color: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: CustomButton(
                              style: getTitleStyle(color: AppColors.white),
                              text: S.of(context).accept,
                              bgcolor: AppColors.primary,
                              onTap: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('Requests')
                                      .doc(widget.id)
                                      .set({
                                    'status': 'accepted',
                                  }, SetOptions(merge: true));
                                  await send(1, widget.name, widget.email);
                                  showSentAlertDialog(context,
                                      title: 'done',
                                      ok: 'ok',
                                      alert:
                                          'request has been accepted Successfuly',
                                      Subtiltle: '', onTap: () {
                                    Navigator.pop(context);
                                  });
                                } catch (e) {
                                  showErrorDialog(context, e.toString());
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: CustomButton(
                              style: getTitleStyle(color: AppColors.white),
                              text: S.of(context).decline,
                              bgcolor: Colors.red,
                              onTap: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('Requests')
                                      .doc(widget.id)
                                      .set({
                                    'status': 'rejected',
                                  }, SetOptions(merge: true));
                                  await send(2, widget.name, widget.email);
                                  showSentAlertDialog(context,
                                      title: 'done',
                                      ok: 'ok',
                                      alert:
                                          'request has been rejected Successfuly',
                                      Subtiltle: '', onTap: () {
                                    Navigator.pop(context);
                                  });
                                } catch (e) {
                                  showErrorDialog(context, e.toString());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
