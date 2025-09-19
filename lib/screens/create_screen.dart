import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'home_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final supabase = Supabase.instance.client;

  final nisnController = TextEditingController();
  final namaController = TextEditingController();
  final genderController = TextEditingController();
  final agamaController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final hpController = TextEditingController();
  final nikController = TextEditingController();

  final jalanController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();
  final dusunController = TextEditingController();
  final desaController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kabupatenController = TextEditingController();
  final provinsiController = TextEditingController();
  final kodePosController = TextEditingController();

  final ayahController = TextEditingController();
  final ibuController = TextEditingController();
  final waliController = TextEditingController();
  final alamatWaliController = TextEditingController();

  String? selectedGender;
  String? selectedAgama;

  String? selectedDusunId;

  @override
  void dispose() {
    nisnController.dispose();
    namaController.dispose();
    genderController.dispose();
    agamaController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    hpController.dispose();
    nikController.dispose();

    jalanController.dispose();
    rtController.dispose();
    rwController.dispose();
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

  Future<void> _pickTanggalLahir() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        tanggalLahirController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _simpanData() async {
    try {
      final siswaId = const Uuid().v4();

      await supabase.from('siswa').insert({
        'siswa_id': siswaId,
        'nisn': nisnController.text,
        'nama_lengkap': namaController.text,
        'jenis_kelamin': selectedGender,
        'agama': selectedAgama,
        'tempat_lahir': tempatLahirController.text,
        'tanggal_lahir': tanggalLahirController.text,
        'no_hp': hpController.text,
        'nik': nikController.text,
      });

      await supabase.from('alamat_siswa').insert({
        'siswa_id': siswaId,
        'jalan': jalanController.text,
        'rt': rtController.text,
        'rw': rwController.text,
        'dusun_id': selectedDusunId,
      });

      await supabase.from('wali').insert({
        'siswa_id': siswaId,
        'nama_ayah': ayahController.text.isNotEmpty
            ? ayahController.text
            : null,
        'nama_ibu': ibuController.text.isNotEmpty ? ibuController.text : null,
        'nama_wali': waliController.text.isNotEmpty
            ? waliController.text
            : null,
        'alamat_wali': alamatWaliController.text.isNotEmpty
            ? alamatWaliController.text
            : null,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data siswa berhasil disimpan!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      debugPrint("Error simpan data: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal simpan data: $e")));
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // widget autocomplete
  Widget dusunDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Desa",
          controller: desaController,
          readOnly: true,
        ),
        _buildTextField(
          label: "Kecamatan",
          controller: kecamatanController,
          readOnly: true,
        ),
        _buildTextField(
          label: "Kabupaten",
          controller: kabupatenController,
          readOnly: true,
        ),
        _buildTextField(
          label: "Provinsi",
          controller: provinsiController,
          readOnly: true,
        ),
        _buildTextField(
          label: "Kode Pos",
          controller: kodePosController,
          readOnly: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C8EBD),
        title: const Text(
          "Tambah Data Siswa",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
              const Text(
                "Data Siswa",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextField(label: "NISN", controller: nisnController),
              _buildTextField(
                label: "Nama Lengkap",
                controller: namaController,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ["Laki-laki", "Perempuan"]
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (val) => setState(() => selectedGender = val),
                  decoration: InputDecoration(
                    labelText: "Jenis Kelamin",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.blue[50],
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF5C8EBD),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: selectedAgama,
                  items:
                      [
                            "Islam",
                            "Kristen",
                            "Katolik",
                            "Hindu",
                            "Buddha",
                            "Konghucu",
                            "Lainnya",
                          ]
                          .map(
                            (a) => DropdownMenuItem(value: a, child: Text(a)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => selectedAgama = val),
                  decoration: InputDecoration(
                    labelText: "Agama",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.blue[50],
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF5C8EBD),
                  ),
                ),
              ),

              _buildTextField(
                label: "Tempat Lahir",
                controller: tempatLahirController,
              ),

              GestureDetector(
                onTap: _pickTanggalLahir,
                child: AbsorbPointer(
                  child: _buildTextField(
                    label: "Tanggal Lahir",
                    controller: tanggalLahirController,
                  ),
                ),
              ),

              _buildTextField(label: "No HP", controller: hpController),
              _buildTextField(label: "NIK", controller: nikController),

              const SizedBox(height: 16),
              const Text(
                "Alamat Siswa",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextField(label: "Jalan", controller: jalanController),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "RT",
                      controller: rtController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      label: "RW",
                      controller: rwController,
                    ),
                  ),
                ],
              ),

              // autocomplete alamat
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TypeAheadField<Map<String, dynamic>>(
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty) return [];
                    final res = await supabase
                        .from('dusun')
                        .select('''
                          dusun_id, nama_dusun,
                          desa:desa_id (
                            nama_desa,
                            kode_pos,
                            kecamatan:kecamatan_id (
                              nama_kecamatan,
                              kabupaten:kabupaten_id (
                                nama_kabupaten,
                                provinsi:provinsi_id (nama_provinsi)
                              )
                            )
                          )
                        ''')
                        .ilike('nama_dusun', '%$pattern%')
                        .limit(10);
                    return List<Map<String, dynamic>>.from(res);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion['nama_dusun'] ?? ''),
                      subtitle: Text(suggestion['desa']['nama_desa'] ?? ''),
                    );
                  },
                  onSelected: (suggestion) {
                    // set text autocomplete
                    dusunController.text = suggestion['nama_dusun'] ?? '';
                    desaController.text = suggestion['desa']['nama_desa'] ?? '';
                    kecamatanController.text =
                        suggestion['desa']['kecamatan']['nama_kecamatan'] ?? '';
                    kabupatenController.text =
                        suggestion['desa']['kecamatan']['kabupaten']['nama_kabupaten'] ??
                        '';
                    provinsiController.text =
                        suggestion['desa']['kecamatan']['kabupaten']['provinsi']['nama_provinsi'] ??
                        '';
                    kodePosController.text =
                        suggestion['desa']['kode_pos'] ?? '';

                    selectedDusunId = suggestion['dusun_id'];
                    setState(() {});
                  },
                  builder: (context, textEditingController, focusNode) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: (val) {
                        setState(() {
                          selectedDusunId = null;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Dusun",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              dusunDetail(),

              const SizedBox(height: 16),
              const Text(
                "Orang Tua / Wali",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextField(label: "Nama Ayah", controller: ayahController),
              _buildTextField(label: "Nama Ibu", controller: ibuController),
              _buildTextField(label: "Nama Wali", controller: waliController),
              _buildTextField(
                label: "Alamat Wali",
                controller: alamatWaliController,
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
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
        ),
      ),
    );
  }
}
