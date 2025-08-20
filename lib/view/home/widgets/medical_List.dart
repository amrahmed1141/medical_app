import 'package:flutter/material.dart';
import 'package:medical_app/controller/category_controller.dart';
import 'package:medical_app/model/category_model.dart';
import 'package:medical_app/view/home/widgets/medical_container.dart';
import 'package:provider/provider.dart';

class MedicalList extends StatelessWidget {
  const MedicalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CategoryController>();
    return SizedBox(
      height: 60,
      child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            final med = categories[index];
            return Selector<CategoryController, bool>(
              selector: (_, model) => model.selectedIndex == index,
              builder: (context, isSelected, child) {
                return GestureDetector(
                  onTap: () {
                    controller.selectCategory(index);
                  },
                  child: MedicalContainer(
                    name: med.name,
                    icon: med.icon,
                    borderColor: isSelected
                        ? const Color(0xff4894FE)
                        : const Color(0xff4894FE),
                    textColor:
                        isSelected ? Colors.white : const Color(0xff4894FE),
                    iconColor:
                        isSelected ? Colors.white : const Color(0xff4894FE),
                    ContainerColor:
                        isSelected ? const Color(0xff4894FE) : Colors.white,
                  ),
                );
              },
            );
          })),
    );
  }
}
