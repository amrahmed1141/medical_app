
class Doctor {
  final int id;
  final String name;
  final String specialty;
  final double rating;
  final String hospital;
  final String image;
  final int reviews;
  final double price;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.hospital,
    required this.image,
    required this.reviews,
    required this.price,
  });
}

 final List<Doctor> doctors = [
    Doctor(
      id: 1,
      name: "Dr. Sarah Johnson",
      specialty: "Cardiologist",
      rating: 4.9,
      hospital: "City Heart Center",
      image: "assets/image/babe.png",
      reviews: 128,
      price: 120,
    ),
    Doctor(
      id: 2,
      name: "Dr. Michael Chen",
      specialty: "Neurologist",
      rating: 4.8,
      hospital: "Neuro Care Hospital",
      image: "assets/image/joseph.png",
      reviews: 95,
      price: 150,
    ),
    Doctor(
      id: 3,
      name: "Dr. Bessie Wilson",
      specialty: "Pediatrician",
      rating: 4.7,
      hospital: "Children's Health",
      image: "assets/image/bessie.png",
      reviews: 210,
      price: 90,
    ),
  ];

