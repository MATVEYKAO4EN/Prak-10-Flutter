// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainStore on _MainStore, Store {
  late final _$selectedMenuIndexAtom =
      Atom(name: '_MainStore.selectedMenuIndex', context: context);

  @override
  int get selectedMenuIndex {
    _$selectedMenuIndexAtom.reportRead();
    return super.selectedMenuIndex;
  }

  @override
  set selectedMenuIndex(int value) {
    _$selectedMenuIndexAtom.reportWrite(value, super.selectedMenuIndex, () {
      super.selectedMenuIndex = value;
    });
  }

  late final _$_MainStoreActionController =
      ActionController(name: '_MainStore', context: context);

  @override
  void selectMenu(int index) {
    final _$actionInfo =
        _$_MainStoreActionController.startAction(name: '_MainStore.selectMenu');
    try {
      return super.selectMenu(index);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedMenuIndex: ${selectedMenuIndex}
    ''';
  }
}
