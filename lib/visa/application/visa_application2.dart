import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadDocumentPage extends StatefulWidget {
  final DocumentSnapshot visa;
  const UploadDocumentPage({super.key, required this.visa});

  @override
  _UploadDocumentPageState createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _photo;
  XFile? _passportCopy;

  @override
  void initState() {
    super.initState();
    _loadExistingDocuments();
  }

  Future<void> _loadExistingDocuments() async {
    final data = widget.visa.data() as Map<String, dynamic>;

    if (data.containsKey('photo') && data['photo'] != null) {
      setState(() {
        _photo = XFile(data['photo']);
      });
    }
    if (data.containsKey('passportCopy') && data['passportCopy'] != null) {
      setState(() {
        _passportCopy = XFile(data['passportCopy']);
      });
    }
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isDenied) {
      // Show rationale or instructions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please grant the required permissions.'),
        ),
      );
    }
  }

  Future<void> _pickImage(String field) async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          if (field == 'photo') {
            _photo = pickedFile;
          } else if (field == 'passportCopy') {
            _passportCopy = pickedFile;
          }
        });

        await widget.visa.reference.set({
          field: pickedFile.path,
        }, SetOptions(merge: true));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Photo access is required to upload images.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: const Text('Upload Documents'),
        // foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Upload Documents',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Image(
                  image: AssetImage('assets/visa/2.png'),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text('Your photo'),
            GestureDetector(
              onTap: () => _pickImage('photo'),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.cloud_upload, color: _photo != null ? Colors.green : Colors.black),
                    SizedBox(width: 10),
                    Text(_photo != null ? 'Update your photo' : 'Upload your photo'),
                    Spacer(),
                    Icon(Icons.question_mark, color: Color(0xFF00BA72)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Passport Copy:'),
            GestureDetector(
              onTap: () => _pickImage('passportCopy'),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.cloud_upload, color: _passportCopy != null ? Colors.green : Colors.black),
                    SizedBox(width: 10),
                    Text(_passportCopy != null ? 'Update your passport copy' : 'Upload your passport copy'),
                    Spacer(),
                    Icon(Icons.question_mark, color: Color(0xFF00BA72)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color(0xFF00BA72),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save and Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
