import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/toDo.dart';
import 'package:todo_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todo_app/ui/views/detay_sayfa.dart';
import 'package:todo_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapildiMi = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().toDoYukle();
  }

  @override
  Widget build(BuildContext context) {
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: aramaYapildiMi
            ? TextField(
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (value) {
                  context.read<AnasayfaCubit>().ara(value);
                },
              )
            : const Text("To Do"),
        actions: [
          aramaYapildiMi
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapildiMi = false;
                    });
                  },
                  icon: const Icon(Icons.search_off_rounded))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapildiMi = true;
                    });
                  },
                  icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<ToDo>>(
        builder: (context, toDoListesi) {
          if (toDoListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: toDoListesi.length,
              itemBuilder: (context, index) {
                var toDo = toDoListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) =>
                                DetaySayfa(yapilacak: toDo))).then((value) {
                      context.read<AnasayfaCubit>().toDoYukle();
                    });
                  },
                  child: Card(
                    color: Colors.blue[200],
                    child: SizedBox(
                      height: yukseklik * 0.13,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              toDo.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(fontSize: genislik * 0.03),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("${toDo.name} silinsin mi"),
                                  action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: () {
                                        context
                                            .read<AnasayfaCubit>()
                                            .sil(toDo.id);
                                      }),
                                ));
                              },
                              icon: const Icon(Icons.clear))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KayitSayfa()))
                .then((value) {
              context.read<AnasayfaCubit>().toDoYukle();
              print("Anasayfaya Dönüldü");
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
