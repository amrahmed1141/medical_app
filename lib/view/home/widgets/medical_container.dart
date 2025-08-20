import 'package:flutter/material.dart';

class MedicalContainer extends StatelessWidget {
    final String name;
  final IconData icon;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final Color ContainerColor;
  const MedicalContainer({Key? key, required this.name, required this.icon, required this.borderColor, required this.textColor, required this.iconColor, required this.ContainerColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: ContainerColor,border: Border.all(color: borderColor),borderRadius: BorderRadius.circular(30)),
        child: Row(children: [
          Icon(icon,size: 20,color: iconColor,),
          const SizedBox(width: 5,),
          Text(name,style: Theme.of(context).textTheme.labelLarge!.apply(color: textColor),)
        ],),
      ),
    );
  }
}