import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:proyectoartistas/pages/perfilArtista.dart';

class PublicarTrabajoScreen extends StatefulWidget {
  const PublicarTrabajoScreen({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  _PublicarTrabajoScreenState createState() => _PublicarTrabajoScreenState();
}

class _PublicarTrabajoScreenState extends State<PublicarTrabajoScreen> {
  int? _tipoTrabajoSeleccionado;
  String? _fechaCreacion;
  double? _precioPrendas;
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  XFile? photo;

  Future getImageFromCamera() async {
    photo = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {});
  }

  Future getImageFromGallery() async {
    photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Seleccionar opción',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Tomar Foto'),
                onTap: () {
                  Navigator.pop(context);
                  getImageFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar de Galería'),
                onTap: () {
                  Navigator.pop(context);
                  getImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> publicarTrabajo() async {
    if (photo == null ||
        _descripcionController.text.isEmpty ||
        _fechaCreacion == null ||
        _tipoTrabajoSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Todos los campos son obligatorios")));
      return;
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://172.17.170.54:5002/api/register_item'),
    );

    request.fields['author'] = widget.userData['user']['name'];
    Map<int, String> tiposTrabajo = {0: 'Murales', 1: 'Prendas', 2: 'Pinturas'};
    request.fields['category'] = tiposTrabajo[_tipoTrabajoSeleccionado!]!;
    request.fields['description'] = _descripcionController.text;
    request.fields['title'] = _titleController.text;
    request.fields['fecha'] = _fechaCreacion!;

    request.fields['price'] = _precioPrendas?.toStringAsFixed(2) ?? '0.0';

    final image = await http.MultipartFile.fromPath(
      'image',
      photo!.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(image);

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item publicado exitosamente")));

        // Limpiar los campos
        setState(() {
          _descripcionController.clear();
          _titleController.clear();
          _fechaCreacion = null;
          _tipoTrabajoSeleccionado = null;
          _precioPrendas = null;
          photo = null;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PerfilArtista(userData: widget.userData),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error al publicar el item")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicar un trabajo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Agregar imagen',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004170)),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _showImagePickerModal,
                child: photo == null
                    ? const Icon(Icons.image_search_rounded,
                        size: 60, color: Color(0xFF004170))
                    : Image.file(File(photo!.path),
                        width: 250, height: 200, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),
              const Text(
                'Título',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004170)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingrese el texto',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Descripción de la obra',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004170)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descripcionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingrese el texto',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tipo de trabajo',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004170)),
              ),
              Column(
                children: [
                  RadioListTile<int>(
                    title: const Text('Murales'),
                    value: 0,
                    groupValue: _tipoTrabajoSeleccionado,
                    onChanged: (value) {
                      setState(() {
                        _tipoTrabajoSeleccionado = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text('Pinturas a mano'),
                    value: 2,
                    groupValue: _tipoTrabajoSeleccionado,
                    onChanged: (value) {
                      setState(() {
                        _tipoTrabajoSeleccionado = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text('Prendas de vestir'),
                    value: 1,
                    groupValue: _tipoTrabajoSeleccionado,
                    onChanged: (value) {
                      setState(() {
                        _tipoTrabajoSeleccionado = value;
                      });
                    },
                  ),
                ],
              ),
              if (_tipoTrabajoSeleccionado == 1 ||
                  _tipoTrabajoSeleccionado == 2) ...[
                const SizedBox(height: 16),
                const Text(
                  'Precio del item',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004170)),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    _precioPrendas = double.tryParse(value);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese el precio',
                  ),
                ),
              ],
              const SizedBox(height: 16),
              const Text(
                'Fecha de creación de la Obra',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004170)),
              ),
              Row(
                children: [
                  Text(
                    _fechaCreacion ?? 'xx/xx/xxxx',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFF004170)),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _fechaCreacion =
                              '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: publicarTrabajo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 12),
                  ),
                  child: const Text(
                    'Publicar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004170)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
