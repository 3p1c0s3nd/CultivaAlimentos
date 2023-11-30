import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalScreen extends StatelessWidget {
  final String title;
  final String img;
  final String section;
  final Map<String, String> descripcion;

  const PrincipalScreen({
    Key? key,
    required this.title,
    required this.img,
    required this.descripcion,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleMediumStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Image(image: AssetImage(img)),
            ),
            const SizedBox(
                height:
                    16.0), // Agregamos un espacio entre la imagen y los puntos
            for (var entry in descripcion.entries)
              GestureDetector(
                onTap: () {
                  context.push('/$section');
                  _loadStoredValue(entry.key);
                  /* showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(entry.key),
                        );
                      });*/
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.primary),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: titleMediumStyle,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        entry.value,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _loadStoredValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("paso", value);
  }
}
