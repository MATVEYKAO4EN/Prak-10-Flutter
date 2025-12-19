import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/documents_store.dart';
import '../../models/document.dart';
import 'package:provider/provider.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final TextEditingController _titleController = TextEditingController();

  // Переносим состояние даты в State
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showAddDocumentDialog() {
    _selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Добавить документ'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Название документа',
                      border: OutlineInputBorder(),
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Дата: '),
                      TextButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null && picked != _selectedDate) {
                            setState(() {
                              _selectedDate = picked;
                            });
                          }
                        },
                        child: Text(
                          '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _titleController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                Observer(builder: (context) {
                  final store = Provider.of<DocumentStore>(context);
                  return ElevatedButton(
                    onPressed: store.isLoading
                        ? null
                        : () async {
                      if (_titleController.text.trim().isNotEmpty) {
                        await store.addDocument(
                          _titleController.text.trim(),
                          _selectedDate,
                        );
                        _titleController.clear();
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text('Добавить'),
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<DocumentStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Документы'),
      ),
      body: Observer(builder: (context) {
        if (store.isLoading && store.documents.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (store.documents.isEmpty) {
          return const Center(
            child: Text(
              'Нет документов',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: store.documents.length,
          itemBuilder: (context, index) {
            final document = store.documents[index];
            return _DocumentItem(
              document: document,
              onDelete: () => store.deleteDocument(document.id),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDocumentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final Document document;
  final VoidCallback onDelete;

  const _DocumentItem({
    required this.document,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.description, color: Colors.blue),
        title: Text(
          document.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Создан: ${document.createdAt.day}.${document.createdAt.month}.${document.createdAt.year}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: () {
          // Навигация к деталям документа
        },
      ),
    );
  }
}