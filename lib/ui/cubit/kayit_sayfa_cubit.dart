import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/todo_dao_repository.dart';

class KayitSayfaCubit extends Cubit<void> {
  KayitSayfaCubit() : super(0);
  var trepo = ToDoRepository();

  Future<void> kaydet(String name) async {
    await trepo.ekle(name);
  }
}
