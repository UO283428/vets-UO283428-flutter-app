import 'package:flutter/material.dart';
import 'package:vets_uo_flutter_app/src/user.dart';
import 'package:vets_uo_flutter_app/pages/user_signup_form.dart';
import 'package:vets_uo_flutter_app/pages/custom_alert_dialog.dart';
import 'package:vets_uo_flutter_app/pages/user_edit_form.dart';
import 'package:vets_uo_flutter_app/pages/user_info.dart';

class HomePage extends StatefulWidget {
  //final String _title;
  const HomePage({super.key}); // recibimos el titulo en el constructor

  @override
  State<StatefulWidget> createState() => StateHomePage();
}

class StateHomePage extends State<HomePage> {
  List<User> users = [
    User("Pedro", "Alvarez", "pedro.alvarez.com", "034-999-999-977"),
    User("María", "Alvarez", "maria.alvarez.com", "034-999-999-978"),
    User("Teresa", "Almonte", "teresa.almonte.com", "034-999-999-979"),
    User("Juan", "Almonte", "juan.almonte.com", "034-999-999-988"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado de clientes")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              User currentUser = users[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserEditForm(user: currentUser),
                ),
              ).then(
                (modifiedUser) => {
                  if (modifiedUser != null)
                    {
                      setState(() {
                        users.removeAt(index);
                        users.insert(index, modifiedUser);
                        String message =
                            "El usuario ${modifiedUser.name} ha sido actualizado correctamenet.";
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomAlertDialog.create(
                                context,
                                'Información',
                                message,
                              ),
                        );
                      }),
                    },
                },
              );
            },
            onLongPress: () {
              deleteUser(context, users[index]);
            },
            title: Text("${users[index].name} ${users[index].surname}"),
            subtitle: Text("${'Teléfono:'}${users[index].phone}"),
            leading: CircleAvatar(
              child: Text(users[index].name.substring(0, 1)),
            ),
            trailing: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfo(user: users[index]),
                  ),
                );
              },
              child: const Icon(Icons.call, color: Colors.black),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserSignUpForm()),
              ).then(
                (newUser) => {
                  if (newUser != null)
                    {
                      setState(() {
                        users.add(newUser);
                        String message =
                            "El usuario ${newUser.name} ha sido registrado";
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomAlertDialog.create(
                                context,
                                'Información',
                                message,
                              ),
                        );
                      }),
                    },
                },
              ),
            },
        tooltip: "Registrar usuario",
        child: const Icon(Icons.add),
      ),
    ); // Scaffold
  }

  deleteUser(BuildContext context, User user) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Borrar usuario"),
            content: Text("Está seguro de borrar el usuario: ${user.name}."),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    users.remove(user);
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  "Borrar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "cancelar",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
    );
  }
}
