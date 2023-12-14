// ignore_for_file: prefer_const_constructors

import 'package:customform/components/dropdown.dart';
import 'package:customform/components/textfield.dart';
import 'package:customform/data/gender_data.dart';
import 'package:customform/screen/userlistscreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:customform/data/user_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneRegex = RegExp(r'^(\+977|0)[1-9]\d{9}$');

  File? _profileImage;
  File? _citizenshipImage;

  bool showWarning = false;
  bool isProfilePhotoMissing = false;
  bool isCitizenshipPhotoMissing = false;
  String? sgender;

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', "abc");
  }

  Future<void> _pickImage(bool isProfile) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
          isProfilePhotoMissing = false;
        } else {
          _citizenshipImage = File(pickedFile.path);
          isCitizenshipPhotoMissing = false;
        }
      });
    }
  }

  void _submitForm() {
    setState(() {
      showWarning = false;
      isProfilePhotoMissing = false;
      isCitizenshipPhotoMissing = false;
    });
    validate_excepttextfield();
    if (_formKey.currentState?.validate() ?? false) {
      saveUserDetails();
      UserDetails newUser = UserDetails(
        name: _nameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
        age: _ageController.text,
        gender: sgender!,
        profileImage: _profileImage,
        citizenshipImage: _citizenshipImage,
      );
      users.add(newUser);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Submission Successful'),
            content: Text('You have successfully submitted the form.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserListScreen()),
                  );
                },
                child: Text('See Data'),
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToUserList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserListScreen()),
    );
  }

  void initState() {
    super.initState();
    loadUserDetails(); // Load user details from Shared Preferences
  }

  void validatedropdown() {
    if (sgender == null) {
      setState(() {
        showWarning = true;
      });
    }
  }

  void validateprofileimage() {
    if (_profileImage == null) {
      setState(() {
        isProfilePhotoMissing = true;
      });
    }
  }

  void validatecitizenshipimage() {
    if (_profileImage == null) {
      setState(() {
        isCitizenshipPhotoMissing = true;
      });
    }
  }

  void validate_excepttextfield() {
    validatedropdown();
    validateprofileimage();
    validatecitizenshipimage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                AppBar(
                  title: const Text('User Details'),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.grey,
                ),
              ],
            ),
          ),
          body: Center(
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              shadowColor: Colors.grey,
                              child: TextInput(
                                hintText: "Enter Your Name Please",
                                labelText: "Name",
                                displayIcon: Icon(Icons.person),
                                customvalidator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                controller: _nameController,
                              ),
                            ),
                            SizedBox(height: 16.0), // Add some spacing
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              shadowColor: Colors.grey,
                              child: TextInput(
                                hintText: "Email",
                                labelText: "Email",
                                displayIcon: Icon(Icons.email),
                                customvalidator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                controller: _emailController,
                              ),
                            ),

                            SizedBox(height: 16.0), // Add some spacing
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              shadowColor: Colors.grey,
                              child: TextInput(
                                hintText: "Phone Number",
                                labelText: "Phone Number",
                                displayIcon: Icon(Icons.lock),
                                customvalidator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone number';
                                  } else if (!phoneRegex.hasMatch(value)) {
                                    return 'Please enter a valid phone number';
                                  } else if (!value.contains("+977")) {
                                    return 'Please enter +977 valid phone number';
                                  }
                                  return null;
                                },
                                controller: _phoneNumberController,
                              ),
                            ),
                            SizedBox(height: 16.0), // Add some spacing
                            TextInput(
                              hintText: "Age",
                              labelText: "Age",
                              displayIcon: Icon(Icons.calendar_month),
                              customvalidator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your age';
                                }
                                return null;
                              },
                              controller: _ageController,
                            ),
                            SizedBox(height: 16.0), // Add some spacing
                            Row(
                              children: [
                                Text("Gender:"),
                                SizedBox(width: 16.0), // Add some spacing
                                MyDropDown(
                                  listFrom: GenderData.genders,
                                  hint: 'Please Select A Gender',
                                  onGenderChanged: (value) {
                                    setState(() {
                                      sgender = value;
                                      showWarning = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                            if (showWarning)
                              Text(
                                'Please select a gender',
                                style: TextStyle(color: Colors.red),
                              ),
                            Row(
                              children: [
                                Text("Profile Picture:"),
                                SizedBox(width: 16.0), // Add some spacing
                                ElevatedButton(
                                  onPressed: () {
                                    _pickImage(true);
                                  },
                                  child: Text("Select image From Gallery"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_profileImage != null)
                                  Image(
                                    image: FileImage(_profileImage!),
                                    height: 100,
                                    width: 200,
                                  )
                                else if (isProfilePhotoMissing)
                                  Visibility(
                                    visible: isProfilePhotoMissing,
                                    child: Text(
                                      'No profile picture selected',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                              ],
                            ),

                            Row(
                              children: [
                                Text("Citizenship:"),
                                SizedBox(width: 16.0), // Add some spacing
                                ElevatedButton(
                                  onPressed: () {
                                    _pickImage(false);
                                  },
                                  child: Text("Select image From Gallery"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_citizenshipImage != null)
                                  Image(
                                    image: FileImage(_citizenshipImage!),
                                    height: 100,
                                    width: 200,
                                  )
                                else if (isCitizenshipPhotoMissing)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    child: Visibility(
                                      visible: isCitizenshipPhotoMissing,
                                      child: Text(
                                        'No Citizenship picture selected',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: Text("Submit"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _navigateToUserList();
                              },
                              child: Text("View User List"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
