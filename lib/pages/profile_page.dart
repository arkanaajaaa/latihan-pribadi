import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pribadiiflutter/controllers/LoginAPIController.dart';
import 'package:latihan_pribadiiflutter/services/storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? token;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final savedUsername = await StorageService.getUsername();
    final savedToken = await StorageService.getToken();
    setState(() {
      username = savedUsername;
      token = savedToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto Profil
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://scontent-cgk2-1.cdninstagram.com/v/t51.29350-15/463142545_1220703232472403_3743763526878522299_n.webp?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkNBUk9VU0VMX0lURU0uaW1hZ2VfdXJsZ2VuLjE0NDB4MTgwMC5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=scontent-cgk2-1.cdninstagram.com&_nc_cat=103&_nc_oc=Q6cZ2QHq0XQLgEvq9BYsv-R123JscU8ET18m0YM2czs6Uqy0uHPvn6zpKoFZ6sczEKwjyZ4&_nc_ohc=gs3Na6TpfywQ7kNvwG8ZR3X&_nc_gid=6cOH_BMk90YCrsWdUHqOtQ&edm=APoiHPcBAAAA&ccb=7-5&ig_cache_key=MzQ3Nzg2MjQwMDUzODU0MjcyMg%3D%3D.3-ccb7-5&oh=00_AfVYXHT9DMugPuO3wI6u7B7wmUc2DoYhYc6ldcHtk60FYQ&oe=68AB021F&_nc_sid=22de04'),
              ),
              const SizedBox(height: 20),

              // Nama
              const Text(
                'Arkana.ajaaa',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Username dari API
              if (username != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_user, color: Colors.blue[700], size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Logged in as: $username',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),

              // Email
              Text(
                'myarkana12@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),

              // Token Info (untuk development)
              if (token != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.key, color: Colors.green[700], size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Auth Token:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        token!.length > 50
                            ? '${token!.substring(0, 50)}...'
                            : token!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green[800],
                          fontFamily: 'monospace',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              // Informasi Lain
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Username'),
                        subtitle: Text('Aindirr'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Telepon'),
                        subtitle: Text('+62 81221448601'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Alamat'),
                        subtitle: Text('Bogor, Jawa Barat'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Show confirmation dialog
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Konfirmasi Logout'),
                        content: const Text(
                            'Apakah Anda yakin ingin keluar dari aplikasi?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              // Call logout from controller
                              try {
                                Get.find<LoginAPIController>().logout();
                              } catch (e) {
                                // If controller not found, create temporary instance
                                final controller = LoginAPIController();
                                controller.logout();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}