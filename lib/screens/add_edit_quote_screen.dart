import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../service/quote_service.dart';
import '../widgets/app_bar.dart';

class AddEditQuoteScreen extends StatefulWidget {
  final Quote? quote;

  AddEditQuoteScreen({this.quote});

  @override
  _AddEditQuoteScreenState createState() => _AddEditQuoteScreenState();
}

class _AddEditQuoteScreenState extends State<AddEditQuoteScreen> {
  final QuoteService service = QuoteService();
  final quoteController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.quote != null) {
      quoteController.text = widget.quote!.quote;
      authorController.text = widget.quote!.author;
    }
  }

  void saveQuote() async {
    final quote = Quote(
      id: widget.quote?.id,
      quote: quoteController.text,
      author: authorController.text,
    );

    if (widget.quote == null) {
      await service.addQuote(quote);
    } else {
      await service.updateQuote(quote);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.quote != null;

    return Scaffold(
      appBar: CustomAppBar(title: isEdit ? "Edit Quote" : "Add Quote"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: quoteController,
              decoration: InputDecoration(labelText: "Quote"),
            ),
            TextField(
              controller: authorController,
              decoration: InputDecoration(labelText: "Author"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveQuote, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
