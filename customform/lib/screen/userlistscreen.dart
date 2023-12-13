import 'package:flutter/material.dart';
import 'package:customform/data/user_data.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    loadUserDetails(); // Load user details from Shared Preferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          UserDetails user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(
              'Email: ${user.email}\nPhone: ${user.phoneNumber}\nAge: ${user.age} \nGender: ${user.gender} ',
            ),
            leading: CircleAvatar(
              backgroundImage: user.profileImage != null
                  ? FileImage(user.profileImage!)
                  : AssetImage('assets/default_profile_image.jpg')
                      as ImageProvider<Object>,
            ),
          );
        },
      ),
    );
  }
}
