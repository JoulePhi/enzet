import 'package:enzet/app/data/contollers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Profile Header
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/logoipsum.png'),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Mr. John Doe',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.blue),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Menu Items
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        title: 'User Profile',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.help_outline,
                        title: 'FAQs',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.notifications_none,
                        title: 'Push Notification',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          Get.find<AuthController>().logout();
                        },
                      ),

                      const SizedBox(height: 40),

                      // Help Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'If you have any other query you can reach out to us.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'WhatsApp Us',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation Bar
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuItem({
  required IconData icon,
  required String title,
  required Function onTap,
  bool isSwitch = false,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.grey[600]),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isSwitch)
            Switch(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.green,
            )
          else
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    ),
  );
}
