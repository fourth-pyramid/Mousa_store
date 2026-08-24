class ContactModel {
  ContactModel({
    this.email,
    this.phone,
    this.whatsapp,
    this.facebook,
    this.address,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    whatsapp: json['whatsapp'] as String?,
    facebook: json['facebook'] as String?,
    address: json['address'] as String?,
  );
  final String? email;
  final String? phone;
  final String? whatsapp;
  final String? facebook;
  final String? address;
}
