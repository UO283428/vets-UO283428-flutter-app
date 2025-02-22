import 'package:flutter/material.dart';
import 'package:vets_uo_flutter_app/src/user.dart';

class UserEditForm extends StatefulWidget {
  final User user;
  const UserEditForm({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => StateUserEditForm();
}

class StateUserEditForm extends State<UserEditForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    User user = widget.user;
    nameController.text = user.name;
    surnameController.text = user.surname;
    emailController.text = user.email;
    phoneController.text = user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modificar datos usuario")),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
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
              onSaved: (value) => nameController.text = value ?? '',
            ),
            TextFormField(
              controller: surnameController,
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
              onSaved: (value) {
                surnameController.text = value ?? '';
              },
            ),
            TextFormField(
              controller: emailController,
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
              onSaved: (value) {
                emailController.text = value ?? '';
              },
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Telefóno',
                hintText: 'Introduce tu teléfono',
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
              onSaved: (value) {
                phoneController.text = value ?? '';
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    _formKey.currentState!.save();
                    User user = User(
                      nameController.text,
                      surnameController.text,
                      emailController.text,
                      phoneController.text,
                    );
                    Navigator.pop(context, user);
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
