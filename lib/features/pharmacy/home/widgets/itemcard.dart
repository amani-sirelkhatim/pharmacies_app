import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.name, required this.image});
  final String name;
  final String image;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.5),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: widget.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        widget.image,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )
                  : SizedBox(),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  widget.name,
                  style: getBodyStyle(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
