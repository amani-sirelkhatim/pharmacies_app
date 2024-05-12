import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/styles.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool issaved = true;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

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
            Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  child: Image.asset('assets/images/antibiotics.jpg')),
              IconButton(
                  onPressed: () {
                    toggleSaved();
                  },
                  icon: Icon(
                    issaved ? Icons.favorite : Icons.favorite_outline_outlined,
                    color: Colors.red,
                  ))
            ]),
            Text(
              'name',
              style: getBodyStyle(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('1000'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
