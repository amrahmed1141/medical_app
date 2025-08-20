import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Icon(
            Iconsax.search_normal,
            color: Color(0xff8696BB),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search doctor or health issue',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Color(0xff8696BB),
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
