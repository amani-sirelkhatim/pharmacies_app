import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/features/user/PatientNav.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
      {super.key,
      required this.pharmacyname,
      required this.orderid,
      required this.status});
  final String pharmacyname;
  final String orderid;
  final String status;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<void> deleteDocument({required String orderid}) async {
    try {
      
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('orderid', isEqualTo: orderid)
          .get();

      // Delete the found document(s)
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary)),
          centerTitle: true,
          title: Text(
            widget.pharmacyname,
            style: getTitleStyle(color: AppColors.primary),
          )),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .where('orderid', isEqualTo: widget.orderid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              var orderData = snapshot.data!.docs;
              var order = orderData[0];
              List items = order['items'];
              return orderData.isNotEmpty && order != null
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
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.circle,
                                                color: AppColors.primary
                                                    .withOpacity(.5),
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  items[index]['image'],
                                                  height: 80,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 7,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    items[index]['name'],
                                                    style: getTitleStyle(),
                                                  ),
                                                  Gap(20),
                                                  Text(
                                                    S.of(context).price +
                                                        ' : ' +
                                                        items[index]['price']
                                                            .toString(),
                                                    style: getBodyStyle(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                                '* ' +
                                                    items[index]['quantity']
                                                        .toString(),
                                                style: getBodyStyle(
                                                    color: AppColors.primary)),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                      color: AppColors.grey.withOpacity(.5),
                                    ),
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
                                    Text(order['totalprice'].toString(),
                                        style: getBodyStyle(
                                            color: AppColors.black
                                                .withOpacity(.7)))
                                  ],
                                ),
                                const Gap(10),
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
                                    Text(order['servicefee'].toString(),
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
                                      order['subtotal'].toString(),
                                      style: getTitleStyle(
                                          color: AppColors.primary),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (widget.status == 'pending')
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomButton(
                              width: double.infinity,
                              text: S.of(context).deleteorder,
                              bgcolor: Colors.red,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                    S
                                                        .of(context)
                                                        .deletewarnning,
                                                    style: getBodyStyle(
                                                        color:
                                                            AppColors.primary)),
                                                Gap(20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                        child: CustomButton(
                                                            text: S
                                                                .of(context)
                                                                .yes,
                                                            bgcolor: Colors.red,
                                                            onTap: () {
                                                              deleteDocument(
                                                                  orderid: widget
                                                                      .orderid);
                                                              pushWithReplacment(
                                                                  context,
                                                                  const PatientNav());
                                                            })),
                                                    Gap(20),
                                                    Expanded(
                                                        child: CustomButton(
                                                            text: S
                                                                .of(context)
                                                                .no,
                                                            bgcolor: AppColors
                                                                .primary,
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }))
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          )
                      ],
                    )
                  : const SizedBox();
            }),
      ),
    );
  }
}
