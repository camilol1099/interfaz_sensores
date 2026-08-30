import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/user.dart';
import 'package:flutter_application_3/ui/user/detail.dart';
import 'package:flutter_application_3/ui/user/add.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  void _editUser(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UserAddScreen(user: user)),
    ).then((_) => setState(() {}));
  }

  Future<void> _deleteUser(User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar usuario'),
        content: Text('¿Deseas eliminar a ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        listUser.removeWhere((u) => u.id == user.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Usuarios'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserAddScreen()),
            ).then((_) => setState(() {})),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listUser.length,
        itemBuilder: (BuildContext context, int index) {
          final user = listUser[index];
          return ExpansionTile(
            leading: CircleAvatar(
              child: Text('${user.id}'),
            ),
            title: Text(user.name),
            subtitle: Text(user.username),
            trailing: const Icon(Icons.call),
            children: [
              UserDetailCard(user: user),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => _editUser(user),
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                  ),
                  TextButton.icon(
                    onPressed: () => _deleteUser(user),
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}