import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/todo_dao_repository.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() : super(0);
  var trepo = ToDoRepository();

  Future<void> guncelle(int id, String name) async {
    await trepo.guncelle(id, name);
  }
}
