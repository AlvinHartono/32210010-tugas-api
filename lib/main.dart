import 'package:http_latihan/form_add.dart';
import 'package:http_latihan/repository.dart';
import 'package:flutter/material.dart';
import 'package:http_latihan/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/formAdd': (context) => const AddBlog(),
      },
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Blog> listBlog = [];
  Repository repository = Repository();

  getData() async {
    listBlog = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Isi Yang Benar"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/formAdd');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .popAndPushNamed('/formAdd', arguments: [
                    listBlog[index].id,
                    listBlog[index].nama,
                    listBlog[index].kota,
                  ]),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listBlog[index].nama),
                        Text(listBlog[index].kota),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    bool response =
                        await repository.deleteData(listBlog[index].id);
                    if (response) {
                      print('Delete data sukses');
                    } else {
                      print('Delete data gagal');
                    }
                    getData();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listBlog.length),
    );
  }
}
