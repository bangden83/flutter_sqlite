import "package:flutter/material.dart";
import "package:flutter_notes_app/pages/home_page.dart";
import "package:flutter_notes_app/utils/user_shared_preferences.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController nameController;
  late TextEditingController pinController;
  bool isPinExist = false;
  String? _pin;

  @override
  void initState() {
    nameController = TextEditingController();
    pinController = TextEditingController();
    UserSharedPreferences.init();
    String? pin = UserSharedPreferences.getPin();
    if (pin != null) {
      setState(() {
        isPinExist = true;
        _pin = pin;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Buku Catatan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Nama',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                controller: nameController,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            // ini bagian PIN
            const Text(
              'PIN',
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            // input field untuk PIN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
              child: TextField(
                controller: pinController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            // jarak
            const SizedBox(
              height: 16,
            ),

            // ini button untuk LOGIN
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    pinController.text.isNotEmpty) {
                  await UserSharedPreferences.setName(
                    name: nameController.text,
                    pin: pinController.text,
                  );
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nama belum disimpan')),
                  );
                }
              },
              child: const Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
