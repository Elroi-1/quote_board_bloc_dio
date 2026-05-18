import 'package:flutter/material.dart';
import 'package:quote_board_bloc/screens/home_screen.dart';
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

    if (!mounted) return;

    // Explicitly navigate to the home screen as requested
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.quote != null;

    return Scaffold(
      appBar: CustomAppBar(title: isEdit ? "Edit Quote" : "Add Quote"),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: quoteController,
                    decoration: InputDecoration(
                      labelText: "Quote",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: authorController,
                    decoration: InputDecoration(
                      labelText: "Author",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(onPressed: saveQuote, child: const Text("Save")),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
