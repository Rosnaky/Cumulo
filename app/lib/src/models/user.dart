import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final DateTime dateOfBirth;
  final String uid;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "dateOfBirth": dateOfBirth.toString(),
        "uid": uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    return User(
      firstName: snap.get("firstName"),
      lastName: snap.get("lastName"),
      email: snap.get("email"),
      dateOfBirth: DateTime.parse(snap.get("dateOfBirth")),
      uid: snap.get("uid"),
    );
  }
}
