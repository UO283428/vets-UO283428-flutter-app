import 'package:flutter/material.dart';
import 'package:vets_uo_flutter_app/src/user.dart';

// Create a Form widget.
class UserSignUpForm extends StatefulWidget {
  const UserSignUpForm({super.key});
  @override
  UserSignUpFormState createState() => UserSignUpFormState();
}

class UserSignUpFormState extends State<UserSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _surname = "";
  String _email = "";
  String _phone = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de usuarios")),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Introduce tu nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'por favor escriba el nombre';
                if (value.trim().length < 2)
                  return 'el nombre debe tener al menos 2 caracteres';
                if (value.trim().length > 50)
                  return 'el nombre no debe superar 50 caracteres';
                return null;
              },
              onSaved: (value) => _name = value ?? '',
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                hintText: 'Introduce tus apellidos',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'por favor escriba los apellidos';
                if (value.trim().length < 2)
                  return 'los apellidos deben tener al menos 2 caracteres';
                if (value.trim().length > 50)
                  return 'los apellidos no deben superar 50 caracteres';
                return null;
              },
              onSaved: (value) => _surname = value ?? '',
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Introduce tu email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'por favor escriba el email';
                final emailRegex = RegExp(
                  r'^[\w\.\-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$',
                );
                if (!emailRegex.hasMatch(value.trim()))
                  return 'introduzca un email valido';
                return null;
              },
              onSaved: (value) => _email = value ?? '',
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Telefóno',
                hintText: 'Introduce tu email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'por favor escriba el telefono';
                final phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
                if (!phoneRegex.hasMatch(value.trim()))
                  return 'introduzca un teléfono valido (999-999-999)';
                return null;
              },
              onSaved: (value) => _phone = value ?? '',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    User user = User(_name, _surname, _email, _phone);
                    Navigator.pop(context, user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
