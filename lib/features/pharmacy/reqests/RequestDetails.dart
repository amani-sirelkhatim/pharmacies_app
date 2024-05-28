import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/pharmacy/pharmacyNav.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/widgets/itemCard.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails(
      {super.key, required this.orderid, required this.status});
  final String orderid;
  final String status;
  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primary)),
            centerTitle: true,
            title: Text(
              S.of(context).order,
              style: getTitleStyle(color: AppColors.primary),
            )),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .doc(widget.orderid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }

                var orderdata = snapshot.data;
                List items = orderdata!['items'];
                return items != null
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: RequestedItemCard(
                                          amount: items[index]['quantity'],
                                          drugname: items[index]['name'],
                                          image: items[index]['image'],
                                          perscription: items[index]
                                              ['perscription'],
                                          price: items[index]['price'],
                                        ));
                                  },
                                  separatorBuilder: (context, index) => Gap(1),
                                  itemCount: items.length),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(.3)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).PaymentSumary,
                                      style: getTitleStyle(
                                          color: AppColors.primary)),
                                  const Gap(20),
                                  Row(
                                    children: [
                                      Text(S.of(context).subtotal,
                                          style: getBodyStyle(
                                              color: AppColors.black
                                                  .withOpacity(.7))),
                                      const Spacer(),
                                      Text(orderdata['totalprice'].toString(),
                                          style: getBodyStyle(
                                              color: AppColors.black
                                                  .withOpacity(.7)))
                                    ],
                                  ),
                                  // const Gap(10),
                                  // Row(
                                  //   children: [
                                  //     Text(S.of(context).deliveryfee,
                                  //         style: getBodyStyle(
                                  //             color: AppColors.black
                                  //                 .withOpacity(.7))),
                                  //     const Spacer(),
                                  //     Text('200',
                                  //         style: getBodyStyle(
                                  //             color: AppColors.black
                                  //                 .withOpacity(.7)))
                                  //   ],
                                  // ),
                                  const Gap(10),
                                  Row(
                                    children: [
                                      Text(S.of(context).Servicefee,
                                          style: getBodyStyle(
                                              color: AppColors.black
                                                  .withOpacity(.7))),
                                      const Spacer(),
                                      Text(orderdata['servicefee'].toString(),
                                          style: getBodyStyle(
                                              color: AppColors.black
                                                  .withOpacity(.7)))
                                    ],
                                  ),
                                  const Gap(10),
                                  Row(
                                    children: [
                                      Text(S.of(context).totalamount,
                                          style: getTitleStyle(
                                              color: AppColors.primary)),
                                      const Spacer(),
                                      Text(
                                        orderdata['subtotal'].toString(),
                                        style: getTitleStyle(
                                            color: AppColors.primary),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.status == 'delivery')
                            CustomButton(
                              text: 'Delivered',
                              bgcolor: AppColors.primary,
                              onTap: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('Orders')
                                      .doc(widget.orderid)
                                      .set({
                                    'status': 'done',
                                  }, SetOptions(merge: true));
                                  showSentAlertDialog(context,
                                      title: 'done',
                                      ok: S.of(context).ok,
                                      alert: S.of(context).done,
                                      Subtiltle: '', onTap: () {
                                    Navigator.pop(context);
                                    pushWithReplacment(context, PharmacyNav());
                                  });
                                } catch (e) {
                                  showErrorDialog(context, e.toString());
                                }
                              },
                            ),
                          widget.status == 'pending'
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  color: AppColors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          child: CustomButton(
                                            style: getTitleStyle(
                                                color: AppColors.white),
                                            text: S.of(context).accept,
                                            bgcolor: AppColors.primary,
                                            onTap: () async {
                                              try {
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(widget.orderid)
                                                    .set({
                                                  'status': 'delivery',
                                                }, SetOptions(merge: true));
                                                showSentAlertDialog(context,
                                                    title: 'done',
                                                    ok: S.of(context).ok,
                                                    alert: S
                                                        .of(context)
                                                        .acceptorder,
                                                    Subtiltle: '', onTap: () {
                                                  Navigator.pop(context);
                                                  pushWithReplacment(context,
                                                      const PharmacyNav());
                                                });
                                              } catch (e) {
                                                showErrorDialog(
                                                    context, e.toString());
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          child: CustomButton(
                                            style: getTitleStyle(
                                                color: AppColors.white),
                                            text: S.of(context).decline,
                                            bgcolor: Colors.red,
                                            onTap: () async {
                                              showDeclineDialog();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      )
                    : const SizedBox();
              }),
        ),
      ),
    );
  }

  showDeclineDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          int reason = 0;
          return SimpleDialog(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(widget.orderid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    }

                    var orderdata = snapshot.data;

                    return orderdata != null
                        ? StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Customer')
                                .doc(orderdata['customerid'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Center(
                                    child: Center(
                                  child: CircularProgressIndicator(),
                                ));
                              }

                              var customer = snapshot.data;
                              return customer != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).declinereason,
                                            style: getTitleStyle(
                                                color: AppColors.primary)),
                                        ListTile(
                                          title: Text(
                                              S
                                                  .of(context)
                                                  .perscriptionisincorect,
                                              style:
                                                  getBodyStyle(fontSize: 15)),
                                          leading: Radio<int>(
                                            value: 1,
                                            groupValue: reason,
                                            activeColor: AppColors.primary,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    AppColors.primary),
                                            splashRadius: 20,
                                            onChanged: (int? value) {
                                              setState(() {
                                                reason = value!;
                                              });
                                              Navigator.pop(context);
                                              handleDecline(
                                                  orderdata, customer, 1);
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            S.of(context).drugnotavailable,
                                            style: getBodyStyle(fontSize: 15),
                                          ),
                                          leading: Radio<int>(
                                            value: 2,
                                            groupValue: reason,
                                            activeColor: AppColors.primary,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    AppColors.primary),
                                            splashRadius: 25,
                                            onChanged: (int? value) {
                                              setState(() {
                                                reason = value!;
                                              });
                                              Navigator.pop(context);
                                              handleDecline(
                                                  orderdata, customer, 2);
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            S.of(context).deliverycomplications,
                                            style: getBodyStyle(fontSize: 15),
                                          ),
                                          leading: Radio<int>(
                                            value: 3,
                                            groupValue: reason,
                                            activeColor: AppColors.primary,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    AppColors.primary),
                                            splashRadius: 25,
                                            onChanged: (int? value) {
                                              setState(() {
                                                reason = value!;
                                              });
                                              Navigator.pop(context);
                                              handleDecline(
                                                  orderdata, customer, 3);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox();
                            })
                        : SizedBox();
                  })
            ],
          );
        });
  }

  Future<void> handleDecline(
      DocumentSnapshot orderdata, DocumentSnapshot customer, int type) async {
    try {
      await send(
          type, orderdata['customername'], widget.orderid, customer['email']);
      await FirebaseFirestore.instance
          .collection('Orders')
          .doc(widget.orderid)
          .set({
        'status': 'declined',
      }, SetOptions(merge: true));
      await showSentAlertDialog(context,
          title: 'done',
          ok: S.of(context).ok,
          alert: S.of(context).declineorder,
          Subtiltle: '', onTap: () {
        Navigator.pop(context);
        pushWithReplacment(context, const PharmacyNav());
      });
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  Future<void> send(int type, String customername, String orderid,
      String customeremail) async {
    late String body;
    late String subject;

    if (type == 1) {
      subject = 'Your Order Has Been Declined';
      body = '''
Dear $customername,

We regret to inform you that your order with the id $orderid has been declined. The prescription provided for the medication does not meet the necessary requirements.

**What You Can Do Next:**

1. Review the prescription to ensure it is correct and up to date.
2. Contact your healthcare provider to obtain a valid prescription.
3. Resubmit your order with the correct prescription.

If you have any questions or need further assistance, please do not hesitate to contact our support team at MediQuick@gmail.com.

We apologize for any inconvenience this may have caused and appreciate your understanding.

Best regards,

The MediaQuick Team
''';
    } else if (type == 2) {
      subject = 'Your Order Has Been Declined';
      body = '''
Dear $customername,

We regret to inform you that your order with the id $orderid  has been declined. Unfortunately, the order is currently not available.

**What You Can Do Next:**

1. Check our website periodically for updates on product availability.
2. Contact our support team to inquire about similar products or alternatives.

We apologize for any inconvenience this may have caused and appreciate your understanding. If you have any questions or need further assistance, please do not hesitate to contact our support team at MediQuick@gmail.com.

Best regards,

The MediQuick Team
''';
    } else {
      subject = 'Your Order Has Been Declined';
      body = '''
Dear $customername,

We regret to inform you that your order with the id $orderid has been declined due to delivery difficulties. Unfortunately, we are currently unable to deliver to the provided address.



We apologize for any inconvenience this may have caused and appreciate your understanding. If you have any questions or need further assistance, please do not hesitate to contact our support team at MediQuick@gmail.com.

Best regards,

The MediQuick Team
''';
    }
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [customeremail],
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
}
