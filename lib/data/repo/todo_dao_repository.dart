import 'package:todo_app/data/entity/toDo.dart';
import 'package:todo_app/sqlite/veritabani_yardimcisi.dart';

class ToDoRepository {
  Future<List<ToDo>> toDoYukle() async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM toDo");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return ToDo(id: satir["id"], name: satir["name"]);
    });
  }

  Future<List<ToDo>> ara(String aramaKelimesi) async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM toDo WHERE name like '%$aramaKelimesi%'");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return ToDo(id: satir["id"], name: satir["name"]);
    });
  }

  Future<void> guncelle(int id, String name) async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    var guncelTodo = Map<String, dynamic>();
    guncelTodo["name"] = name;
    await db.update("toDo", guncelTodo, where: "id = ?", whereArgs: [id]);
  }

  Future<void> ekle(String name) async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    var yeniToDo = Map<String, dynamic>();
    yeniToDo["name"] = name;
    await db.insert("toDo", yeniToDo);
  }

  Future<void> sil(int id) async {
    var db = await VeriTabaniYardimcisi.veritabaniErisim();
    await db.delete("todo", where: "id =?", whereArgs: [id]);
  }
}
