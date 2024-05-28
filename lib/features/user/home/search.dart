import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/drugPage.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
    required this.drug,
  });
  final String drug;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .orderBy('name')
              .startAt([widget.drug]).endAt(
                  ['${widget.drug}\uf8ff']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data?.docs == null) {
              return const SizedBox(); // or return a loading indicator if needed
            }

            var drugs = snapshot.data?.docs;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: (drugs != null && drugs.isNotEmpty)
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                S.of(context).searchresults + ' : ',
                                style: getBodyStyle(color: AppColors.primary),
                              )
                            ],
                          ),
                          SizedBox(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = index < drugs.length
                                    ? drugs[index].data()
                                    : null;
                                return item != null
                                    ? GestureDetector(
                                        onTap: () {
                                          push(
                                              context,
                                              DrugPage(
                                                pharmacyname:
                                                    item['pharmacyname'] ?? '',
                                                productid: item['drugid'] ?? '',
                                              ));
                                        },
                                        child: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.primary
                                                .withOpacity(.1),
                                          ),
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: item[
                                                            'frontimage'] ==
                                                        null
                                                    ? AssetImage(
                                                        'assets/icons/profile.png',
                                                      ) as ImageProvider<Object>
                                                    : NetworkImage(
                                                            item['frontimage'])
                                                        as ImageProvider<
                                                            Object>,
                                              ),
                                              title: Text(
                                                item['name'] ?? '',
                                                style: getBodyStyle(),
                                              ),
                                              subtitle: Text(
                                                item['pharmacyname'] ?? '',
                                                style: getSmallStyle(
                                                    color: AppColors.grey,
                                                    fontSize: 12),
                                              ),
                                              trailing: Icon(
                                                Icons.more_horiz_rounded,
                                                color: AppColors.primary,
                                              )),
                                        ),
                                      )
                                    : SizedBox();
                              },
                              itemCount: 4,
                              separatorBuilder: (context, index) => Gap(20),
                            ),
                          )),
                        ],
                      )
                    : Column(
                        children: [
                          Gap(200),
                          Icon(
                            Icons.search_off_rounded,
                            color: AppColors.primary,
                            size: 100,
                          ),
                          Center(
                            child: Text(
                              S.of(context).nosearch,
                              style: getTitleStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          }),
    );
  }
}
