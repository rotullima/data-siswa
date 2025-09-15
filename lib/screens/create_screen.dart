import 'package:flutter/material.dart';
import 'home_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  // Controllers
  final nisnController = TextEditingController();
  final namaController = TextEditingController();
  final genderController = TextEditingController();
  final agamaController = TextEditingController();
  final ttlController = TextEditingController();
  final hpController = TextEditingController();
  final nikController = TextEditingController();

  // Alamat
  final jalanController = TextEditingController();
  final rtrwController = TextEditingController();
  final dusunController = TextEditingController();
  final desaController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kabupatenController = TextEditingController();
  final provinsiController = TextEditingController();
  final kodePosController = TextEditingController();

  // Orang Tua / Wali
  final ayahController = TextEditingController();
  final ibuController = TextEditingController();
  final waliController = TextEditingController();
  final alamatWaliController = TextEditingController();

  @override
  void dispose() {
    nisnController.dispose();
    namaController.dispose();
    genderController.dispose();
    agamaController.dispose();
    ttlController.dispose();
    hpController.dispose();
    nikController.dispose();

    jalanController.dispose();
    rtrwController.dispose();
    dusunController.dispose();
    desaController.dispose();
    kecamatanController.dispose();
    kabupatenController.dispose();
    provinsiController.dispose();
    kodePosController.dispose();

    ayahController.dispose();
    ibuController.dispose();
    waliController.dispose();
    alamatWaliController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  void _simpanData() {
    // dummy debug
    debugPrint("NISN: ${nisnController.text}");
    debugPrint("Nama: ${namaController.text}");

    // balik ke HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF5C8EBD),
        title: const Text(
          "Tambah Data Siswa",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Data Siswa",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _buildTextField(label: "NISN", controller: nisnController),
              _buildTextField(label: "Nama Lengkap", controller: namaController),
              _buildTextField(
                  label: "Jenis Kelamin", controller: genderController),
              _buildTextField(label: "Agama", controller: agamaController),
              _buildTextField(
                  label: "Tempat Tanggal Lahir", controller: ttlController),
              _buildTextField(label: "No HP", controller: hpController),
              _buildTextField(label: "NIK", controller: nikController),

              const SizedBox(height: 16),
              const Text("Alamat Siswa",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _buildTextField(label: "Jalan", controller: jalanController),
              _buildTextField(label: "RT / RW", controller: rtrwController),
              _buildTextField(label: "Dusun", controller: dusunController),
              _buildTextField(label: "Desa", controller: desaController),
              _buildTextField(
                  label: "Kecamatan", controller: kecamatanController),
              _buildTextField(
                  label: "Kabupaten", controller: kabupatenController),
              _buildTextField(label: "Provinsi", controller: provinsiController),
              _buildTextField(
                  label: "Kode Pos", controller: kodePosController),

              const SizedBox(height: 16),
              const Text("Orang Tua / Wali",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _buildTextField(label: "Nama Ayah", controller: ayahController),
              _buildTextField(label: "Nama Ibu", controller: ibuController),
              _buildTextField(label: "Nama Wali", controller: waliController),
              _buildTextField(
                  label: "Alamat Wali", controller: alamatWaliController),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 92, 142, 189),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                  ),
                  onPressed: _simpanData,
                  child: const Text(
                    "Simpan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
