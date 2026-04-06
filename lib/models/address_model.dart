class AddressModel {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  
  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });
  
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      country: json['country'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'state': state,
    'zipCode': zipCode,
    'country': country,
  };
}
