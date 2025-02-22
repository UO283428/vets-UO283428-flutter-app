import 'package:flutter/material.dart';
import 'package:vets_uo_flutter_app/src/user.dart';

class UserInfo extends StatefulWidget {
  final User user;
  const UserInfo({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => StateUserInfo();
}

class StateUserInfo extends State<UserInfo> {
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
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Introduce tu nombre',
                border: OutlineInputBorder(),
                enabled: false, // Disable editing
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'por Favor digite el nombre';
                }
                return null;
              },
              onSaved: (value) => nameController.text = value ?? '',
            ),
            TextFormField(
              controller: surnameController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                hintText: 'Introduce tu apellidos',
                border: OutlineInputBorder(),
                enabled: false, // Disable editing
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'por favor digite los apellidos';
                }
                return null;
              },
              onSaved: (value) {
                surnameController.text = value ?? '';
              },
            ),
            TextFormField(
              controller: emailController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Introduce tu email',
                border: OutlineInputBorder(),
                enabled: false, // Disable editing
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'por favor digite el  email';
                }
                return null;
              },
              onSaved: (value) {
                emailController.text = value ?? '';
              },
            ),
            TextFormField(
              controller: phoneController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Telefóno',
                hintText: 'Introduce tu email',
                border: OutlineInputBorder(),
                enabled: false, // Disable editing
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'por favor digite el telefono ';
                }
                return null;
              },
              onSaved: (value) {
                phoneController.text = value ?? '';
              },
            ),
          ],
        ),
      ),
    );
  }
}
