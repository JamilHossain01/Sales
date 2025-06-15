class PetProfileModel {
  final String title;
  final String location;
  final double weight;
  final int ageYears;
  final int ageMonths;
  final String breed;
  final String gender;
  final bool isVaccinated;
  final bool isChipped;
  final bool isNeutered;
  final String description;
  final List<String> images;

  final String shelterName;
  final String shelterLocation;
  final String shelterPhone;
  final String shelterEmail;
  final String shelterImageUrl;

  PetProfileModel({
    required this.title,
    required this.location,
    required this.weight,
    required this.ageYears,
    required this.ageMonths,
    required this.breed,
    required this.gender,
    required this.isVaccinated,
    required this.isChipped,
    required this.isNeutered,
    required this.description,
    required this.images,
    required this.shelterName,
    required this.shelterLocation,
    required this.shelterPhone,
    required this.shelterEmail,
    required this.shelterImageUrl,
  });
}
