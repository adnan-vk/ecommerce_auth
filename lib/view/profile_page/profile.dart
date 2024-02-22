import 'package:authentication/controller/authenticarion_provider/auth_provider.dart';
import 'package:authentication/view/wishlist/wishlist.dart';
import 'package:authentication/view/login_page/selectlogin.dart';
import 'package:authentication/view/profile_page/about_appp.dart';
import 'package:authentication/view/profile_page/privacy.dart';
import 'package:authentication/view/profile_page/settings/settings.dart';
import 'package:authentication/view/welcome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolor.orange,
        centerTitle: true,
        title: const Text("SETTINGS"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height * 1,
          color: const Color.fromARGB(255, 240, 240, 240),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "ADNAN",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        onp: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutApp(),
                            )),
                        context,
                        icon: Icons.info_outline,
                        title: "About This App",
                      ),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                        onp: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Privacy(),
                            )),
                        context,
                        icon: Icons.privacy_tip_outlined,
                        title: "Privacy And Security",
                      ),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                        context,
                        onp: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            )),
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                        context,
                        onp: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WishList(),
                            )),
                        icon: Icons.favorite_border,
                        title: "Wishlist",
                      ),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                        context,
                        onp: () => sheet(context),
                        icon: Icons.logout_outlined,
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback? onp}) {
    return GestureDetector(
      onTap: () {
        onp!();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: appcolor.black,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(icon, color: appcolor.orange),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(color: appcolor.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sheet(BuildContext context) {
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text("LOG OUT"),
              Text(
                "DO YOU WANT TO LOG OUT FROM THIS USER",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 3, 45, 79)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "CANCEL",
                )),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 3, 45, 79))),
                onPressed: () {
                  pro.signOutEmail();
                  pro.googleSignout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectLoginTypePage(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text(
                  "LOGOUT",
                )),
          ],
        );
      },
    );
  }
}
