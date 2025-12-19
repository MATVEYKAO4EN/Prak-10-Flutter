// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_UserStore.canLogin'))
      .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_UserStore.canRegister'))
          .value;

  late final _$loginAtom = Atom(name: '_UserStore.login', context: context);

  @override
  String get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(String value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_UserStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_UserStore.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_UserStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_UserStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_UserStore.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('_UserStore.register', context: context);

  @override
  Future<bool> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  late final _$loginUserAsyncAction =
      AsyncAction('_UserStore.loginUser', context: context);

  @override
  Future<bool> loginUser() {
    return _$loginUserAsyncAction.run(() => super.loginUser());
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('_UserStore.deleteAccount', context: context);

  @override
  Future<bool> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  void setLogin(String value) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setLogin');
    try {
      return super.setLogin(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentUser(String login) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setCurrentUser');
    try {
      return super.setCurrentUser(login);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.clear');
    try {
      return super.clear();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
login: ${login},
password: ${password},
confirmPassword: ${confirmPassword},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
currentUser: ${currentUser},
canLogin: ${canLogin},
canRegister: ${canRegister}
    ''';
  }
}
