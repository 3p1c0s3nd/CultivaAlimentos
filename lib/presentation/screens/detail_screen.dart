import 'package:flutter/material.dart';
import 'package:app_cocechar/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatelessWidget {
  final String tipo;

  const DetailScreen({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tipo),
      ),
      body: _DetailScreenView(tipo: tipo),
    );
  }
}

class _DetailScreenView extends StatefulWidget {
  final String tipo;

  const _DetailScreenView({Key? key, required this.tipo}) : super(key: key);

  @override
  _DetailScreenViewState createState() => _DetailScreenViewState();
}

class _DetailScreenViewState extends State<_DetailScreenView> {
  String paso = "";

  @override
  void initState() {
    super.initState();
    _loadPaso();
  }

  _loadPaso() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      paso = prefs.getString('paso') ??
          ""; // Cambia 'paso' por tu clave personalizada
    });
  }

  Widget _buildWidgets(Map<String, dynamic> tipoDetail) {
    final widgets = <Widget>[];

    tipoDetail.forEach((key, value) {
      if (key.toString() == paso.toString()) {
        if (value is String) {
          widgets.add(centradoFont('$key: $value', value));
        } else if (value is Map<String, dynamic>) {
          for (var item in value.entries) {
            widgets.add(
              Card(
                elevation: 1.0,
                shadowColor: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.value is List<String>) ...[
                      centradoFont('${item.key}:', "null"),
                      for (var dd in item.value) textoFont('* $dd'),
                    ] else
                      centradoFont('+ ${item.key}', item.value),
                  ],
                ),
              ),
            );
          }
        }
      }

      // Puedes agregar más casos según la estructura de tus datos
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: DetailJson().detail.length,
              itemBuilder: (context, index) {
                final info = DetailJson().detail[index];

                if (info.containsKey(widget.tipo)) {
                  final tipoDetail = info[widget.tipo];

                  // Construye dinámicamente widgets para mostrar la información
                  return Card(
                    child: _buildWidgets(tipoDetail),
                  );
                } else {
                  return const Text('Información no disponible');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget centradoFont(String text, String descripcion) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Center(
              child: Text(
            style: Theme.of(context).textTheme.headline6,
            text,
          )),
          if (descripcion != 'null') textoFont(descripcion),
        ],
      ),
    );
  }

  Widget textoFont(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 20.0),
        child: Text(
          style: TextStyle(fontSize: 13.0),
          text,
        ));
  }
}
