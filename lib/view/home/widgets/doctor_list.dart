import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/controller/doctors/doc_controller.dart';
import 'package:medical_app/model/doctors/doctors_model.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(0xff4894FE)),
            ),
          );
        }
        
        if (controller.doctors.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services,
                  size: 64,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  "No doctors available",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please check back later",
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          itemCount: controller.doctors.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final doctor = controller.doctors[index];
            return _buildDoctorCard(doctor, context);
          },
        );
      },
    );
  }

  Widget _buildDoctorCard(Doctor doctor, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to doctor details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Avatar
              _buildDoctorAvatar(doctor),
              
              const SizedBox(width: 16),
              
              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Specialty
                    _buildDoctorInfo(doctor),
                    
                    const SizedBox(height: 8),
                    
                    // Hospital and Rating
                    _buildHospitalAndRating(doctor),
                    
                    const SizedBox(height: 8),
                    
                    // Price and Availability
                    _buildPriceAndAvailability(doctor),
                  ],
                ),
              ),
              
              // Book Button
              _buildBookButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorAvatar(Doctor doctor) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(doctor.imageUrl),
          onBackgroundImageError: (exception, stackTrace) {
            // Handle image loading errors
          },
        ),
      ],
    );
  }

  Widget _buildDoctorInfo(Doctor doctor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          doctor.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        
        const SizedBox(height: 4),
        
        Row(
          children: [
            _getSpecialtyIcon(doctor.specialty),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                doctor.specialty,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHospitalAndRating(Doctor doctor) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 14,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            doctor.hospital,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        
        const SizedBox(width: 12),
        
        Icon(
          Icons.star,
          size: 14,
          color: Colors.amber,
        ),
        const SizedBox(width: 2),
        Text(
          doctor.rating.toString(),
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          ' (${doctor.reviewsCount})',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndAvailability(Doctor doctor) {
    return Row(
      children: [
        Text(
          '\$${doctor.pricePerHour.toStringAsFixed(0)}/hr',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff4894FE),
          ),
        ),
        
        
      ],
    );
  }

  Widget _buildBookButton() {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xff4894FE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.calendar_today,
            size: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Book',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xff4894FE),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper function to get specialty icon
  Icon _getSpecialtyIcon(String specialty) {
    final specialtyLower = specialty.toLowerCase();
    
    if (specialtyLower.contains('cardio')) {
      return const Icon(FontAwesomeIcons.heartPulse, size: 14, color: Colors.red);
    } else if (specialtyLower.contains('neuro')) {
      return const Icon(FontAwesomeIcons.brain, size: 14, color: Colors.purple);
    } else if (specialtyLower.contains('pediatric')) {
      return const Icon(FontAwesomeIcons.baby, size: 14, color: Colors.pink);
    } else if (specialtyLower.contains('ortho')) {
      return const Icon(FontAwesomeIcons.bone, size: 14, color: Colors.brown);
    } else if (specialtyLower.contains('derm')) {
      return const Icon(FontAwesomeIcons.handSparkles, size: 14, color: Colors.orange);
    } else if (specialtyLower.contains('eye') || specialtyLower.contains('ophthal')) {
      return const Icon(FontAwesomeIcons.eye, size: 14, color: Colors.blue);
    } else if (specialtyLower.contains('ent') || specialtyLower.contains('ear')) {
      return const Icon(FontAwesomeIcons.earListen, size: 14, color: Colors.green);
    } else if (specialtyLower.contains('dent')) {
      return const Icon(FontAwesomeIcons.tooth, size: 14, color: Colors.teal);
    } else if (specialtyLower.contains('pulmon')) {
      return const Icon(FontAwesomeIcons.lungs, size: 14, color: Colors.cyan);
    } else {
      return const Icon(Icons.medical_services, size: 14, color: Colors.grey);
    }
  }
}

