import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportBugPage extends StatefulWidget {
  const ReportBugPage({Key? key}) : super(key: key);

  @override
  _ReportBugPageState createState() => _ReportBugPageState();
}

class _ReportBugPageState extends State<ReportBugPage> {
  final _formKey = GlobalKey<FormState>();
  final _bugDescriptionController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _bugDescriptionController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _reportBug() async {
    if (_formKey.currentState!.validate()) {
      final bugDescription = _bugDescriptionController.text;
      final email = _emailController.text;

      try {
        await FirebaseFirestore.instance.collection('bug_reports').add({
          'description': bugDescription,
          'email': email,
          'reportedAt': FieldValue.serverTimestamp(),
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: const Text('Thank You!', style: TextStyle(color: Colors.white)),
              content: const Text('Bug reported successfully!', style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.amber),),
                ),
              ],
            );
          },
        );

        _bugDescriptionController.clear();
        _emailController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to report bug. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/icons/R-streaming-TEXT-logo.png',
                  height: 50,
                ),
                Text(
                  "Thank you for joining R STREAMING entertainment:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Divider(height: 2,),
                SizedBox(height: 10,)
              ],

            ),
            SizedBox(height: 15,),
            Text('Report A Bug', style: TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold, ),),
            SizedBox(height: 15,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _bugDescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Bug Description',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a bug description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: _reportBug,
                      child: const Text('Report Bug',style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold, )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                        textStyle: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
