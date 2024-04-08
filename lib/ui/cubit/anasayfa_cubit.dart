import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/toDo.dart';
import 'package:todo_app/data/repo/todo_dao_repository.dart';

class AnasayfaCubit extends Cubit<List<ToDo>> {
  AnasayfaCubit() : super(<ToDo>[]);

  var trepo = ToDoRepository();
  Future<void> toDoYukle() async {
    var list = await trepo.toDoYukle();
    emit(list);
  }

  Future<void> sil(int id) async {
    await trepo.sil(id);
    await toDoYukle();
  }

  Future<void> ara(String aramaKelimesi) async {
    var list = await trepo.ara(aramaKelimesi);
    emit(list);
  }
}
