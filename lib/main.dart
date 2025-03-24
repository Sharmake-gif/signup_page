import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signup Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              // First Name
              FormBuilderTextField(
                name: 'first_name',
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Last Name
              FormBuilderTextField(
                name: 'last_name',
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Email Address
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Contact Number
              FormBuilderTextField(
                name: 'contact_number',
                decoration: const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Contact number is required';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Date of Birth
              FormBuilderDateTimePicker(
                name: 'dob',
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                validator: (value) {
                  if (value == null) {
                    return 'Date of Birth is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final formData = _formKey.currentState!.value;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationScreen(formData),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fix errors")),
                    );
                  }
                },
                child: const Text("Sign Up Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> formData;

  const ConfirmationScreen(this.formData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Signup Successful!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("First Name: ${formData['first_name']}"),
            Text("Last Name: ${formData['last_name']}"),
            Text("Email: ${formData['email']}"),
            Text("Contact Number: ${formData['contact_number']}"),
            Text("DOB: ${DateFormat('yyyy-MM-dd').format(formData['dob'])}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
