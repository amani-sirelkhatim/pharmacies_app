import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CatCard extends StatefulWidget {
  const CatCard({super.key, required this.Cat, required this.image});
  final String Cat;
  final String image;

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: 250,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.image,
                    width: 120,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              widget.Cat,
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 15,
                shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    offset: const Offset(2, 2), // Shadow position
                    blurRadius: 3, // Shadow blur radius
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
