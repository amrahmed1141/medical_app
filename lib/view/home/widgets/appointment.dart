import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppointment extends StatelessWidget {
  const MyAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 138,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff4894FE),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/image/imran.png',
                    width: 48,
                    height: 48,
                  ),
                ),
                const  SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Dr. Imran Syahir',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:  Color(0xffFFFFFF),
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        'General Doctor',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color(0xffCBE1FF),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward,color: Colors.white,)
              ],
            ),
            const Spacer(),
            Divider(
              color: Colors.white.withOpacity(0.15),
              height: 1,
              thickness: 1,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const ImageIcon(
                        AssetImage(
                          'assets/icon/ic_calendar.png',
                        ),
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8,),
                      Text(
                        DateFormat('EEEE, d MMMM').format(DateTime.now()),
                        style:const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color:  Color(0xffFFFFFF),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: const [
                      ImageIcon(
                        AssetImage(
                          'assets/icon/ic_clock.png',
                        ),
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        '11:00 - 12:00 AM',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Color(0xffFFFFFF),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}