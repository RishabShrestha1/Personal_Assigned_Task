import 'dart:io';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  final String name;
  final String email;
  final String phoneNumber;
  final String age;
  final String gender;
  final File? profileImage;
  final File? citizenshipImage;

  UserDetails({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    this.profileImage,
    this.citizenshipImage,
  });
  // Convert User Details to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'age': age,
      'gender': gender,
      'profileImage': profileImage?.path,
      'citizenshipImage': citizenshipImage?.path,
    };
  }

  // Create UserDetails from Map
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      age: map['age'],
      gender: map['gender'],
      profileImage:
          map['profileImage'] != null ? File(map['profileImage']) : null,
      citizenshipImage: map['citizenshipImage'] != null
          ? File(map['citizenshipImage'])
          : null,
    );
  }
}

List<UserDetails> users = [];

Future<void> saveUserDetails() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    const key = 'userDetails';
    final value = users.map((user) => user.toMap()).toList();
    prefs.setStringList(key, value.map((e) => jsonEncode(e)).toList());
    print('User details saved successfully');
  } catch (e) {
    print('Error saving user details: $e');
  }
}

// Load user data from Shared Preferences
Future<void> loadUserDetails() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    const key = 'userDetails';
    final value = prefs.getStringList(key);
    if (value != null) {
      users = value.map((e) => UserDetails.fromMap(jsonDecode(e))).toList();
      print('User details loaded successfully');
    }
  } catch (e) {
    print('Error loading user details: $e');
  }
}
