import 'package:flutter/material.dart';
import 'package:medical_app/view/home/widgets/appointment.dart';
import 'package:medical_app/view/home/widgets/doctor_list.dart';
import 'package:medical_app/view/home/widgets/header.dart';
import 'package:medical_app/view/home/widgets/medical_List.dart';
import 'package:medical_app/view/home/widgets/my_search.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            HomeHeader(),
             const SizedBox(height: 10,),
            MySearchBar(),
             const SizedBox(height: 20,),
            MyAppointment(),
            const SizedBox(height: 10,),
            MedicalList(),
            const SizedBox(height: 10,),
            DoctorList()
          ],
        ),
      )),
    );
  }
}
