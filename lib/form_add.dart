import 'package:http_latihan/repository.dart';
import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => AddBlogState();
}

class AddBlogState extends State<AddBlog> {
  Repository repository = Repository();
  final _namaController = TextEditingController();
  final _kotaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tambah data"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(hintText: 'nama'),
            ),
            TextField(
              controller: _kotaController,
              decoration: const InputDecoration(hintText: 'kota'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await repository.postData(
                    _namaController.text, _kotaController.text);

                if (response) {
                  Navigator.of(context).popAndPushNamed('/home');
                } else {
                  print("salah!!!");
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
