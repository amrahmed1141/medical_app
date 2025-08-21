class Doctor {
  final int id;
  final String name;
  final String specialty; // This is important for filtering
  final String hospital;
  final double rating;
  final int reviewsCount;
  final String about;
  final String imageUrl;
  final double pricePerHour;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty, // Make sure this exists
    required this.hospital,
    required this.rating,
    required this.reviewsCount,
    required this.about,
    required this.imageUrl,
    required this.pricePerHour,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '', // This field
      hospital: json['hospital'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviews_count'] ?? 0,
      about: json['about'] ?? '',
      imageUrl: json['image_url'] ?? '',
      pricePerHour: (json['price_per_hour'] ?? 0.0).toDouble(),
    );
  }
}