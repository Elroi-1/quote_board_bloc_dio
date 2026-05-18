import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_board_bloc/features/quotes/data/repositories/quote_repository.dart';
import 'package:quote_board_bloc/features/quotes/presentation/bloc/quote_bloc.dart';
import 'package:quote_board_bloc/features/quotes/presentation/screens/home_screen.dart';
import 'package:quote_board_bloc/theme/app_colors.dart';

void main() {
  final quoteRepository = QuoteRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => QuoteBloc(quoteRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.appBackground),
        home: HomeScreen(),
      ),
    ),
  );
}
