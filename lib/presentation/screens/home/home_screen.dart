import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cocechar/config/info/info_json.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Que Quieres Cultivar?'),
      ),
      body: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: InfoJson().info.length,
      itemBuilder: (context, index) {
        final info = InfoJson().info[index];
        // Utiliza el widget _CustomListTile y retórnalo
        return _CustomListTile(
          title: info['title'],
          subtitle: info['subtitle'],
          location: info['route'],
        );
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String location;

  const _CustomListTile({
    required this.title,
    required this.subtitle,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push("/$location"));
  }
}
