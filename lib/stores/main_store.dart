import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  @observable
  int selectedMenuIndex = 0;

  @action
  void selectMenu(int index) {
    selectedMenuIndex = index;
  }
}