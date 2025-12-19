// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DocumentStore on _DocumentStore, Store {
  late final _$documentsAtom =
      Atom(name: '_DocumentStore.documents', context: context);

  @override
  ObservableList<Document> get documents {
    _$documentsAtom.reportRead();
    return super.documents;
  }

  @override
  set documents(ObservableList<Document> value) {
    _$documentsAtom.reportWrite(value, super.documents, () {
      super.documents = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_DocumentStore.isLoading', context: context);

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

  late final _$addDocumentAsyncAction =
      AsyncAction('_DocumentStore.addDocument', context: context);

  @override
  Future<void> addDocument(String title, DateTime date) {
    return _$addDocumentAsyncAction.run(() => super.addDocument(title, date));
  }

  late final _$deleteDocumentAsyncAction =
      AsyncAction('_DocumentStore.deleteDocument', context: context);

  @override
  Future<void> deleteDocument(String id) {
    return _$deleteDocumentAsyncAction.run(() => super.deleteDocument(id));
  }

  late final _$loadDocumentsAsyncAction =
      AsyncAction('_DocumentStore.loadDocuments', context: context);

  @override
  Future<void> loadDocuments() {
    return _$loadDocumentsAsyncAction.run(() => super.loadDocuments());
  }

  @override
  String toString() {
    return '''
documents: ${documents},
isLoading: ${isLoading}
    ''';
  }
}
