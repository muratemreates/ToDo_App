import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/toDo.dart';
import 'package:todo_app/ui/cubit/detay_sayfa_cubit.dart';

// ignore: must_be_immutable
class DetaySayfa extends StatefulWidget {
  DetaySayfa({required this.yapilacak});
  ToDo yapilacak;

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfToDo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Detay Sayfa"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    tfToDo.text = widget.yapilacak.name;
                  },
                  child: Text(
                    widget.yapilacak.name,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
                TextField(
                  controller: tfToDo,
                  decoration: const InputDecoration(
                      hintText: "Yapılacak şeyi yazınız.."),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            context
                .read<DetaySayfaCubit>()
                .guncelle(widget.yapilacak.id, tfToDo.text);
            setState(() {
              widget.yapilacak.name = tfToDo.text;
            });
            print("Güncellendi...");
            tfToDo.text = "";
          },
          child: const Text("Güncelle")),
    );
  }
}
