import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/Auth/presentation/admin/requestdetails.dart';


class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pharmacy Requests',
            style: getTitleStyle(color: AppColors.primary)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Requests').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text(
                    'there are no saved products yet',
                    style: getBodyStyle(color: AppColors.primary),
                  ),
                );
              }
              var data = snapshot.data!.docs;
              return data != null && data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var req = index < data.length
                            ? data[index].data() as Map<String, dynamic>
                            : null;
                        return req != null
                            ? GestureDetector(
                                onTap: () {
                                  push(
                                      context,
                                      Req(
                                        id: req['id'],
                                        email: req['pharmacyemail'],
                                        pdf: req['permission'],
                                        name: req['pharmacyname'],
                                        status: req['status'],
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: AppColors.grey)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.local_pharmacy,
                                            color: AppColors.primary,
                                            size: 15,
                                          ),
                                          const Gap(20),
                                          Text(
                                            req['pharmacyname'],
                                            style: getBodyStyle(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.email,
                                              color: AppColors.primary,
                                              size: 15),
                                          const Gap(20),
                                          Text(
                                            req['pharmacyemail'],
                                            style: getBodyStyle(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      })
                  : Center(
                      child: Text(
                        'there are no requests at the moment',
                        style: getTitleStyle(color: AppColors.primary),
                      ),
                    );
            }),
      ),
    );
  }
}
