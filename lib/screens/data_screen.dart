import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  // Data dummy siswa
  List<Map<String, dynamic>> siswa = [
    {
      "nisn": "001",
      "nama": "Abir Fauziah Agung",
      "gender": "Perempuan",
      "agama": "Islam",
      "ttl": "Malang, 12 Jan 2007",
      "hp": "08123456789",
      "nik": "1234567890123456",
      "alamat": "Jl. Gelap No. 10, Malang",
      "ayah": "Bapak Tegar Saputra",
      "ibu": "Ibu Melati Putri",
    },
    {
      "nisn": "002",
      "nama": "Bagas Sumanyo",
      "gender": "Laki-laki",
      "agama": "Kristen",
      "ttl": "Bandung, 5 Feb 2007",
      "hp": "08987654321",
      "nik": "2345678901234567",
      "alamat": "Jl. Melati No. 5, Bandung",
      "ayah": "Bapak Joseph Sumanyo",
      "ibu": "Ibu Citra Kendedes",
    },
    {
      "nisn": "003",
      "nama": "Clarissa Nia",
      "gender": "Perempuan",
      "agama": "Islam",
      "ttl": "Jambi, 20 Mar 2007",
      "hp": "08765432109",
      "nik": "3456789012345678",
      "alamat": "Jl. Kenanga No. 7, Surabaya",
      "ayah": "Bapak Novian Satya",
      "ibu": "Ibu Novi Elisa",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Urutkan berdasarkan nama (A-Z)
    siswa.sort((a, b) => a["nama"].compareTo(b["nama"]));

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF5C8EBD),
        title: const Text(
          "Data Siswa",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: siswa.length,
        itemBuilder: (context, index) {
          final item = siswa[index];
          final isMale = item["gender"] == "Laki-laki";

          return Card(
            color: isMale ? const Color(0xFF5C8EBD) : const Color(0xFFBD6784),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                item["nama"],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "NISN: ${item["nisn"]}",
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () => _showDetailPopup(item),
            ),
          );
        },
      ),
    );
  }

  void _showDetailPopup(Map<String, dynamic> data) {
    final nisnC = TextEditingController(text: data["nisn"]);
    final namaC = TextEditingController(text: data["nama"]);
    final genderC = TextEditingController(text: data["gender"]);
    final agamaC = TextEditingController(text: data["agama"]);
    final ttlC = TextEditingController(text: data["ttl"]);
    final hpC = TextEditingController(text: data["hp"]);
    final nikC = TextEditingController(text: data["nik"]);
    final alamatC = TextEditingController(text: data["alamat"]);
    final ayahC = TextEditingController(text: data["ayah"]);
    final ibuC = TextEditingController(text: data["ibu"]);

    bool isEdit = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Text(
                        isEdit ? "Edit Data" : "Detail Siswa",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      isEdit
                          ? Column(
                              children: [
                                _buildTextField("NISN", nisnC),
                                _buildTextField("Nama", namaC),
                                _buildTextField("Jenis Kelamin", genderC),
                                _buildTextField("Agama", agamaC),
                                _buildTextField("Tempat Tanggal Lahir", ttlC),
                                _buildTextField("No HP", hpC),
                                _buildTextField("NIK", nikC),
                                _buildTextField("Alamat", alamatC),
                                _buildTextField("Nama Ayah", ayahC),
                                _buildTextField("Nama Ibu", ibuC),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetail("NISN", data["nisn"]),
                                _buildDetail("Nama", data["nama"]),
                                _buildDetail("Jenis Kelamin", data["gender"]),
                                _buildDetail("Agama", data["agama"]),
                                _buildDetail("TTL", data["ttl"]),
                                _buildDetail("No HP", data["hp"]),
                                _buildDetail("NIK", data["nik"]),
                                _buildDetail("Alamat", data["alamat"]),
                                _buildDetail("Nama Ayah", data["ayah"]),
                                _buildDetail("Nama Ibu", data["ibu"]),
                              ],
                            ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5C8EBD),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(120, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 4,
                            ),
                            onPressed: () {
                              if (isEdit) {
                                setState(() {
                                  data["nisn"] = nisnC.text;
                                  data["nama"] = namaC.text;
                                  data["gender"] = genderC.text;
                                  data["agama"] = agamaC.text;
                                  data["ttl"] = ttlC.text;
                                  data["hp"] = hpC.text;
                                  data["nik"] = nikC.text;
                                  data["alamat"] = alamatC.text;
                                  data["ayah"] = ayahC.text;
                                  data["ibu"] = ibuC.text;
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Data ${data['nama']} berhasil diupdate",
                                    ),
                                  ),
                                );
                              } else {
                                setStateDialog(() {
                                  isEdit = true;
                                });
                              }
                            },
                            icon: Icon(isEdit ? Icons.save : Icons.edit),
                            label: Text(isEdit ? "Simpan" : "Edit"),
                          ),
                          if (!isEdit)
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFBD6784),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(120, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                _hapusData(data);
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text("Hapus"),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDetail(String label, String value) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}


  Widget _buildTextField(String label, TextEditingController controller) {
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
          fillColor: Colors.blue[50],
        ),
      ),
    );
  }

  void _hapusData(Map<String, dynamic> data) {
    setState(() {
      siswa.remove(data);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data ${data['nama']} berhasil dihapus")),
    );
  }
}
