import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medical_app/model/doctors/doctors_model.dart';
import 'package:medical_app/view/booking/booking.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;
  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text(
          doctor.name,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      doctor.imageUrl,
                      height: 450,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.calendar_today,
                          color: const Color(0xff4894FE),
                        )),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Iconsax.verify5,
                  color: Colors.blueAccent,
                ),
              ],
            ),
            Text(
              doctor.specialty,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.local_hospital, color: Colors.redAccent),
                const SizedBox(width: 8),
                Text(doctor.hospital, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text("${doctor.rating} (${doctor.reviewsCount} reviews)"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green),
                Text("${doctor.pricePerHour} / hour",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/image/maps.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "About",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              doctor.about,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingScreen(doctor: doctor)));
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  primary: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Booking Appointment",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
