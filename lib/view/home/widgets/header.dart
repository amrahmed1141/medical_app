import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
               Text(
                  'Hello,',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color:  Color(0xff8696BB),
                    height: 1,
                  ),
                ),
               SizedBox(height: 5,),
                Text(
                  'Hi James',
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff0D1B34),
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/image/profile.png',
            width: 56,
            height: 56,
          ),
        ],
      ),
    );
  }
}