import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/user.dart';

class UserDetailCard extends StatelessWidget {
  const UserDetailCard({super.key, required this.user});

  final User user;

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  List<Widget> _section(List<Widget> rows) {
    if (rows.isEmpty) return const [];
    return [const Divider(), ...rows];
  }

  @override
  Widget build(BuildContext context) {
    final address = user.address;
    final geo = address.geo;
    final company = user.company;

    final contactRows = <Widget>[
      if (user.email.isNotEmpty) _row('Email', user.email),
      if (user.phone.isNotEmpty) _row('Phone', user.phone),
      if (user.website.isNotEmpty) _row('Website', user.website),
    ];

    final addressRows = <Widget>[
      if (address.street.isNotEmpty) _row('Street', address.street),
      if (address.suite.isNotEmpty) _row('Suite', address.suite),
      if (address.city.isNotEmpty) _row('City', address.city),
      if (address.zipcode.isNotEmpty) _row('Zipcode', address.zipcode),
      if (geo.lat.isNotEmpty || geo.lng.isNotEmpty)
        _row('Geo', '${geo.lat}, ${geo.lng}'),
    ];

    final companyRows = <Widget>[
      if (company.name.isNotEmpty) _row('Company', company.name),
      if (company.catchPhrase.isNotEmpty) _row('Catch', company.catchPhrase),
      if (company.bs.isNotEmpty) _row('Bs', company.bs),
    ];

    final children = <Widget>[
      ...contactRows,
      ..._section(addressRows),
      ..._section(companyRows),
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
