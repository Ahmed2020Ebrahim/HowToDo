import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_to_do/featuers/auth/presentation/blocs/auth/bloc/auth_bloc.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../../auth/presentation/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isArabic = false;
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black),
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---------------- Language Switch ----------------
          SwitchListTile(
            title: const Text('Language: English / Arabic'),
            value: isArabic,
            activeColor: Colors.deepOrange,
            onChanged: (val) {
              setState(() => isArabic = val);
            },
          ),

          // ---------------- Theme Switch ----------------
          SwitchListTile(
            title: const Text('Theme: Light / Dark'),
            value: isDarkTheme,
            activeColor: Colors.deepOrange,
            onChanged: (val) {
              setState(() => isDarkTheme = val);
            },
          ),

          // ---------------- Navigation ListTiles ----------------
          ListTile(
            trailing: const Icon(Icons.lock_outline, color: Colors.deepOrange),
            title: const Text('Change Password'),
            onTap: () {},
          ),
          ListTile(
            trailing: const Icon(Icons.notifications_none, color: Colors.deepOrange),
            title: const Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            trailing: const Icon(Icons.description_outlined, color: Colors.deepOrange),
            title: const Text('Terms & Conditions'),
            onTap: () {},
          ),
          ListTile(
            trailing: const Icon(Icons.phone, color: Colors.deepOrange),
            title: const Text("Contact us"),
            onTap: () {},
          ),
          ListTile(
            trailing: const Icon(Icons.question_mark, color: Colors.deepOrange),
            title: const Text("Who we are"),
            onTap: () {},
          ),

          const SizedBox(height: 24),

          // ---------------- Horizontal Buttons ----------------
          Divider(),
          Text(
            "Save your Current Tasks to Internet And get it any time you want",
            style: TextTheme.of(context).labelSmall!.copyWith(color: Colors.grey),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: () {},
              child: const Text('Save Tasks'),
            ),
          ),
          const SizedBox(height: 8),
          Divider(),
          Text(
            "Get your saved data from Internet and use it",
            style: TextTheme.of(context).labelSmall!.copyWith(color: Colors.grey),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: () {},
              child: const Text('Get Tasks'),
            ),
          ),

          const SizedBox(height: 12),

          Divider(),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {},
              child: const Text('Delete Account'),
            ),
          ),
          const SizedBox(width: 8),
          Divider(),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: OutlinedButton(
              onPressed: () {
                //show confirm dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            //remove login cradintial from local storage
                            context.read<AuthBloc>().add(LoggedOut());
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                              (route) => false,
                            );
                          },
                          child: Text("Logout"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
