import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/models/user.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({super.key, this.user});

  final User? user;

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    if (user != null) {
      _nameController.text = user.name;
      _usernameController.text = user.username;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _websiteController.text = user.website;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final existing = widget.user;
    if (existing != null) {
      final updated = User(
        id: existing.id,
        name: _nameController.text,
        username: _usernameController.text,
        email: _emailController.text,
        address: existing.address,
        phone: _phoneController.text,
        website: _websiteController.text,
        company: existing.company,
      );
      final index = listUser.indexWhere((u) => u.id == existing.id);
      if (index != -1) {
        listUser[index] = updated;
      }
      Navigator.pop(context);
      return;
    }

    final nextId = listUser.isEmpty
        ? 1
        : listUser.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1;

    final newUser = User(
      id: nextId,
      name: _nameController.text,
      username: _usernameController.text,
      email: _emailController.text,
      address: Address(
        street: '',
        suite: '',
        city: '',
        zipcode: '',
        geo: Geo(lat: '', lng: ''),
      ),
      phone: _phoneController.text,
      website: _websiteController.text,
      company: Company(name: '', catchPhrase: '', bs: ''),
    );

    listUser.add(newUser);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Agregar usuario' : 'Editar usuario'),
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Requerido' : null,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Requerido' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Requerido';
                final emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                );
                if (!emailRegex.hasMatch(value)) return 'Correo invalido';
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Telefono'),
              keyboardType: TextInputType.phone,
              maxLength: widget.user == null ? 10 : null,
              inputFormatters: widget.user == null
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
              validator: (value) {
                if (value == null || value.isEmpty) return 'Requerido';
                if (widget.user == null &&
                    !RegExp(r'^\d{10}$').hasMatch(value)) {
                  return 'Deben ser 10 digitos';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(labelText: 'Website'),
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                final websiteRegex = RegExp(
                  r'^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+(\/[^\s]*)?$',
                );
                if (!websiteRegex.hasMatch(value)) return 'Website invalido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
