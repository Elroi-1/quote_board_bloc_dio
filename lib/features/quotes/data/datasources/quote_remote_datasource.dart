import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/quote_model.dart';

class QuoteRemoteDatasource {
  final Dio _dio;

  QuoteRemoteDatasource({Dio? dio}) : _dio = dio ?? DioProvider.dio;

  Future<List<Quote>> fetchQuotes() async {
    try {
      final response = await _dio.get(ApiConstants.quotesPath);
      final List data = response.data['quotes'];
      return data.map((e) => Quote.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> addQuote(Quote quote) async {
    try {
      await _dio.post('${ApiConstants.quotesPath}/add', data: quote.toJson());
    } catch (_) {}
  }

  Future<void> updateQuote(Quote quote) async {
    try {
      await _dio.put('${ApiConstants.quotesPath}/${quote.id}', data: quote.toJson());
    } catch (_) {}
  }

  Future<void> deleteQuote(int id) async {
    try {
      await _dio.delete('${ApiConstants.quotesPath}/$id');
    } catch (_) {}
  }
}
