import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/quote_repository.dart';
import 'quote_event.dart';
import 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;

  QuoteBloc(this.quoteRepository) : super(QuoteInitial()) {
    on<GetQuotesEvent>(_onGetQuotes);
    on<AddQuoteEvent>(_onAddQuote);
    on<UpdateQuoteEvent>(_onUpdateQuote);
    on<DeleteQuoteEvent>(_onDeleteQuote);
  }

  Future<void> _onGetQuotes(
    GetQuotesEvent event,
    Emitter<QuoteState> emit,
  ) async {
    emit(QuoteLoading());
    try {
      final quotes = await quoteRepository.getQuotes();
      emit(QuoteLoaded(quotes));
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  Future<void> _onAddQuote(
    AddQuoteEvent event,
    Emitter<QuoteState> emit,
  ) async {
    try {
      await quoteRepository.addQuote(event.quote);
      add(GetQuotesEvent());
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  Future<void> _onUpdateQuote(
    UpdateQuoteEvent event,
    Emitter<QuoteState> emit,
  ) async {
    try {
      await quoteRepository.updateQuote(event.quote);
      add(GetQuotesEvent());
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  Future<void> _onDeleteQuote(
    DeleteQuoteEvent event,
    Emitter<QuoteState> emit,
  ) async {
    try {
      await quoteRepository.deleteQuote(event.id);
      add(GetQuotesEvent());
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }
}
