import 'package:flutter/material.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Near Doctor",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: const Color(0xff0D1B34),
            height: 1,
          ),
        ),
        const SizedBox(height: 16,),
        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            String image = 'assets/image/imran.png';
            String name = 'Dr. Joseph Brostito';
            String specialist = 'Dental Specialist';
            String range = '1.2 KM';
            double rate = 4.8;
            int review = 120;
            String open = '17.00';
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: const Offset(2, 12),
                    color: const Color(0xff5A75A7).withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          image,
                          width: 48,
                          height: 48,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: const Color(0xff0D1B34),
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Text(
                              specialist,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: const Color(0xff8696BB),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icon/ic_location.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 8,),
                          Text(
                            range,
                            style:TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: const Color(0xff8696BB),
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Divider(
                    color: Color(0xffF5F5F5),
                    height: 1,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage(
                                'assets/icon/ic_clock.png',
                              ),
                              size: 20,
                              color: Color(0xffFEB052),
                            ),
                            const SizedBox(width: 8,),
                            Text(
                              '$rate ($review Reviews)',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: const Color(0xffFEB052),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage(
                                'assets/icon/ic_clock.png',
                              ),
                              size: 20,
                              color: Color(0xff4894FE),
                            ),
                            const SizedBox(width: 8,),
                            Text(
                              'Open at $open',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: const Color(0xff4894FE),
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
            );
          },
        ),
      ],
    );

  }
}