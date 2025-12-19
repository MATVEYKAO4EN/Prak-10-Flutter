import 'package:mobx/mobx.dart';
import '../models/document.dart';

part 'documents_store.g.dart';

class DocumentStore = _DocumentStore with _$DocumentStore;

abstract class _DocumentStore with Store {
  @observable
  ObservableList<Document> documents = ObservableList<Document>.of([
    Document(
      id: '1',
      title: 'Договор аренды',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Document(
      id: '2',
      title: 'Счет на оплату',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Document(
      id: '3',
      title: 'Отчет за квартал',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ]);

  @observable
  bool isLoading = false;

  @action
  Future<void> addDocument(String title, DateTime date) async {
    isLoading = true;

    await Future.delayed(const Duration(milliseconds: 500));

    final newDocument = Document(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: date,
    );

    documents.insert(0, newDocument);
    isLoading = false;
  }

  @action
  Future<void> deleteDocument(String id) async {
    isLoading = true;
    await Future.delayed(const Duration(milliseconds: 300));
    documents.removeWhere((doc) => doc.id == id);
    isLoading = false;
  }

  @action
  Future<void> loadDocuments() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
  }
}