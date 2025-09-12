import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_user == null) return;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .get();

    if (doc.exists) {
      setState(() {
        _userData = doc.data() as Map<String, dynamic>?;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _userData?['photoUrl'] != null
                        ? NetworkImage(_userData!['photoUrl'])
                        : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
                  ),
                  // ... rest of your profile widgets
                ],
              ),
            ),
    );
  }
}