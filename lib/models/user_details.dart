import 'package:cloud_firestore/cloud_firestore.dart';
class UserDetails {
  String firstname;
  String lastname;
  String gender;
  String maritalstatus;
  String emailId;
  String pannumber;
  DateTime? dob;

  UserDetails({
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.maritalstatus,
    required this.emailId,
    required this.pannumber,
    required this.dob,
  });

  // Convert UserDetails object to JSON Map (for Firebase)
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'maritalstatus': maritalstatus,
      'emailId': emailId,
      'pannumber': pannumber,
      'dob': dob != null ? Timestamp.fromDate(dob!) : null,
    };
  }

  // Create UserDetails object from JSON Map (from Firebase)
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      gender: json['gender'] ?? '',
      maritalstatus: json['maritalstatus'] ?? '',
      emailId: json['emailId'] ?? '',
      pannumber: json['pannumber'] ?? '',
      dob: json['dob'] != null 
          ? (json['dob'] as Timestamp).toDate() 
          : null,
    );
  }

  // Alternative: Create from DocumentSnapshot (Firebase document)
  factory UserDetails.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserDetails.fromJson(data);
  }

  // Convert to Map without Firestore-specific types (for other JSON operations)
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'maritalstatus': maritalstatus,
      'emailId': emailId,
      'pannumber': pannumber,
      'dob': dob?.toIso8601String(),
    };
  }

  // Create from Map with ISO string dates (for other JSON operations)
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      gender: map['gender'] ?? '',
      maritalstatus: map['maritalstatus'] ?? '',
      emailId: map['emailId'] ?? '',
      pannumber: map['pannumber'] ?? '',
      dob: map['dob'] != null ? DateTime.parse(map['dob']) : null,
    );
  }

  // Create a copy of the object with updated values
  UserDetails copyWith({
    String? firstname,
    String? lastname,
    String? gender,
    String? maritalstatus,
    String? emailId,
    String? pannumber,
    DateTime? dob,
  }) {
    return UserDetails(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      maritalstatus: maritalstatus ?? this.maritalstatus,
      emailId: emailId ?? this.emailId,
      pannumber: pannumber ?? this.pannumber,
      dob: dob ?? this.dob,
    );
  }

  // Override toString for better debugging
  @override
  String toString() {
    return 'UserDetails(firstname: $firstname, lastname: $lastname, gender: $gender, maritalstatus: $maritalstatus, emailId: $emailId, pannumber: $pannumber, dob: $dob)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserDetails &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.gender == gender &&
        other.maritalstatus == maritalstatus &&
        other.emailId == emailId &&
        other.pannumber == pannumber &&
        other.dob == dob;
  }

  // Override hashCode
  @override
  int get hashCode {
    return firstname.hashCode ^
        lastname.hashCode ^
        gender.hashCode ^
        maritalstatus.hashCode ^
        emailId.hashCode ^
        pannumber.hashCode ^
        dob.hashCode;
  }
}