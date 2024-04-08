import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfToDo = TextEditingController();
  var yazi = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ekle")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                yazi,
                style: const TextStyle(fontSize: 25),
              ),
              TextField(
                controller: tfToDo,
                decoration: const InputDecoration(
                    hintText: "Yapılacak bir şey yazın.."),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            context.read<KayitSayfaCubit>().kaydet(tfToDo.text).then((value) {
              print("Anasayfaya dönüldü");
              print(" TO DO Eklendi");
              setState(() {
                yazi = tfToDo.text;
              });
            });
          },
          child: const Text("Ekle")),
    );
  }
}
