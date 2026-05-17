import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../service/quote_service.dart';
import '../widgets/app_bar.dart';
import 'add_edit_quote_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuoteService service = QuoteService();
  late Future<List<Quote>> quotesFuture;

  @override
  void initState() {
    super.initState();
    quotesFuture = service.getQuotes();
  }

  void refresh() {
    setState(() {
      quotesFuture = service.getQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Quote Board"),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditQuoteScreen()),
          );
          refresh();
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Quote>>(
        future: quotesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          final quotes = snapshot.data!;

          return ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final quote = quotes[index];
              return Card(
                child: ListTile(
                  title: Text(quote.quote),
                  subtitle: Text(quote.author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditQuoteScreen(quote: quote),
                            ),
                          );
                          refresh();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await service.deleteQuote(quote.id!);
                          refresh();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
