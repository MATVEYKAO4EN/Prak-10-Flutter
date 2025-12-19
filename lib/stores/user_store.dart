import 'package:mobx/mobx.dart';
import '../models/user.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  String login = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  User? currentUser;

  @computed
  bool get canLogin => login.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canRegister =>
      login.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          password == confirmPassword;

  @action
  void setLogin(String value) {
    login = value;
    errorMessage = null;
  }

  @action
  void setPassword(String value) {
    password = value;
    errorMessage = null;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
    errorMessage = null;
  }

  @action
  void setCurrentUser(String login) {
    currentUser = User(
      login: login,
      registrationDate: DateTime.now(),
    );
  }

  @action
  Future<bool> register() async {
    if (!canRegister) {
      errorMessage = 'Заполните все поля и проверьте совпадение паролей';
      return false;
    }

    isLoading = true;
    errorMessage = null;

    // Имитация задержки сети
    await Future.delayed(const Duration(seconds: 1));

    setCurrentUser(login);
    isLoading = false;

    // В реальном приложении здесь был бы API вызов
    return true;
  }

  @action
  Future<bool> loginUser() async {
    if (!canLogin) {
      errorMessage = 'Заполните все поля';
      return false;
    }

    isLoading = true;
    errorMessage = null;

    // Имитация задержки сети
    await Future.delayed(const Duration(seconds: 1));

    setCurrentUser(login);
    isLoading = false;

    // В реальном приложении здесь был бы API вызов
    return true;
  }

  @action
  Future<bool> deleteAccount() async {
    isLoading = true;

    // Имитация удаления аккаунта
    await Future.delayed(const Duration(seconds: 1));

    isLoading = false;
    currentUser = null;
    clear();

    return true;
  }

  @action
  void clear() {
    login = '';
    password = '';
    confirmPassword = '';
    errorMessage = null;
    isLoading = false;
  }
}