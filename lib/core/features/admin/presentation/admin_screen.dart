import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _ratingController = TextEditingController();
  final _experienceController = TextEditingController();
  final _feeController = TextEditingController();
  final _addressController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  final _aboutController = TextEditingController();
  final _imageController = TextEditingController();
  bool _isAvailable = true;

  // Specialty dropdown
  String _selectedSpecialty = 'Cardiologist';
  final List<String> _specialties = [
    'Cardiologist',
    'Dentist',
    'Neurologist',
    'Orthopedic',
    'Pediatrician',
    'Dermatologist',
    'General Physician',
    'ENT Specialist',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _ratingController.dispose();
    _experienceController.dispose();
    _feeController.dispose();
    _addressController.dispose();
    _latController.dispose();
    _lngController.dispose();
    _aboutController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _addDoctor() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('doctors').add({
        'name': _nameController.text.trim(),
        'specialty': _selectedSpecialty,
        'rating': _ratingController.text.trim(),
        'experience': _experienceController.text.trim(),
        'fee': _feeController.text.trim(),
        'address': _addressController.text.trim(),
        'lat': _latController.text.trim(),
        'lng': _lngController.text.trim(),
        'about': _aboutController.text.trim(),
        'image': _imageController.text.trim().isEmpty
            ? 'https://i.pravatar.cc/150?img=${DateTime.now().millisecond}'
            : _imageController.text.trim(),
        'isAvailable': _isAvailable.toString(),
        'createdAt': DateTime.now().toIso8601String(),
      });

      setState(() => _isLoading = false);

      // Form clear karo
      _nameController.clear();
      _ratingController.clear();
      _experienceController.clear();
      _feeController.clear();
      _addressController.clear();
      _latController.clear();
      _lngController.clear();
      _aboutController.clear();
      _imageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doctor added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const _DoctorListAdminScreen(),
              ),
            ),
            icon: const Icon(Icons.list, color: Colors.white),
            tooltip: 'View All Doctors',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F1FB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_circle_outline,
                        color: Color(0xFF2563EB)),
                    SizedBox(width: 10),
                    Text(
                      'Add New Doctor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Name
              _buildLabel('Doctor Name'),
              _buildField(
                controller: _nameController,
                hint: 'Dr. Ahmed Khan',
                icon: Icons.person_outline,
                validator: (v) =>
                v!.isEmpty ? 'Name is required' : null,
              ),

              const SizedBox(height: 16),

              // Specialty Dropdown
              _buildLabel('Specialty'),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSpecialty,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: _specialties
                        .map((s) => DropdownMenuItem(
                      value: s,
                      child: Text(s),
                    ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedSpecialty = v!),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Rating + Experience row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Rating (0-5)'),
                        _buildField(
                          controller: _ratingController,
                          hint: '4.5',
                          icon: Icons.star_outline,
                          keyboardType:
                          TextInputType.number,
                          validator: (v) =>
                          v!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Experience (yrs)'),
                        _buildField(
                          controller: _experienceController,
                          hint: '10',
                          icon: Icons.work_outline,
                          keyboardType:
                          TextInputType.number,
                          validator: (v) =>
                          v!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Fee
              _buildLabel('Consultation Fee (Rs.)'),
              _buildField(
                controller: _feeController,
                hint: '1500',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (v) =>
                v!.isEmpty ? 'Fee is required' : null,
              ),

              const SizedBox(height: 16),

              // Address
              _buildLabel('Clinic Address'),
              _buildField(
                controller: _addressController,
                hint: 'Gulberg III, Lahore',
                icon: Icons.location_on_outlined,
                validator: (v) =>
                v!.isEmpty ? 'Address is required' : null,
              ),

              const SizedBox(height: 16),

              // Lat + Lng row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Latitude'),
                        _buildField(
                          controller: _latController,
                          hint: '31.5204',
                          icon: Icons.map_outlined,
                          keyboardType:
                          TextInputType.number,
                          validator: (v) =>
                          v!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Longitude'),
                        _buildField(
                          controller: _lngController,
                          hint: '74.3587',
                          icon: Icons.map_outlined,
                          keyboardType:
                          TextInputType.number,
                          validator: (v) =>
                          v!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // About
              _buildLabel('About Doctor'),
              TextFormField(
                controller: _aboutController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                  'Experienced doctor with specialization in...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFF2563EB)),
                  ),
                ),
                validator: (v) =>
                v!.isEmpty ? 'About is required' : null,
              ),

              const SizedBox(height: 16),

              // Image URL
              _buildLabel('Image URL (optional)'),
              _buildField(
                controller: _imageController,
                hint: 'https://i.pravatar.cc/150?img=1',
                icon: Icons.image_outlined,
              ),

              const SizedBox(height: 16),

              // Available toggle
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border:
                  Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: Color(0xFF2563EB)),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Available Today',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Switch(
                      value: _isAvailable,
                      onChanged: (v) =>
                          setState(() => _isAvailable = v),
                      activeColor: const Color(0xFF2563EB),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _addDoctor,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                      color: Colors.white)
                      : const Text(
                    'Add Doctor',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1E293B),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Color(0xFF2563EB)),
        ),
      ),
      validator: validator,
    );
  }
}

// Doctor List Admin Screen — edit/delete
class _DoctorListAdminScreen extends StatelessWidget {
  const _DoctorListAdminScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.white),
        ),
        title: const Text(
          'All Doctors',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Color(0xFF2563EB)),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No doctors added yet'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data =
              doc.data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        data['image'] ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(
                              width: 50,
                              height: 50,
                              color: const Color(0xFFE6F1FB),
                              child: const Icon(Icons.person,
                                  color: Color(0xFF2563EB)),
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            data['specialty'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF2563EB),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Rs.${data['fee']} • ${data['experience']} yrs',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Delete button
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title:
                            const Text('Delete Doctor'),
                            content: Text(
                                'Delete ${data['name']}?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child:
                                const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('doctors')
                                      .doc(doc.id)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}