import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies_flutter/bloc/movie_detail_bloc/movie_detail_cubit.dart';
import 'package:popular_movies_flutter/localization/tKeys.dart';
import 'package:popular_movies_flutter/utils/colors.dart';
import 'package:popular_movies_flutter/utils/constants.dart';

class ErrorMessage extends StatefulWidget {
  static const String id = "error_screen";

  const ErrorMessage({Key? key}) : super(key: key);

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.mainColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(context.read<MovieDetailCubit>().state.errorMessage, style: kMainTextStyle),
              Text(TKeys.errorMessage.translate(context), style: kMainTextStyle),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(TKeys.tryAgain.translate(context), style: kMainTextStyle),
                  color: Colors.white12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
