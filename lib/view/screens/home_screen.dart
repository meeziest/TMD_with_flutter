import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies_flutter/bloc/popular_movies_bloc/popular_movies_cubit.dart';
import 'package:popular_movies_flutter/localization/localiztion_service.dart';
import 'package:popular_movies_flutter/localization/tKeys.dart';
import 'package:popular_movies_flutter/utils/colors.dart';
import 'package:popular_movies_flutter/utils/constants.dart';
import 'package:popular_movies_flutter/view/widgets/drop_down_button.dart';
import 'package:popular_movies_flutter/view/widgets/movies_list.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: (){
                        context.read<PopularMovieCubit>().fetchList(LocalizationService.currentLocale);
                      },
                      child: AutoSizeText(
                        TKeys.appTitle.translate(context),
                        minFontSize: 10,
                        maxFontSize: 40,
                        maxLines: 1,
                        style: kAppBarTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:const EdgeInsets.only(left: 10),
                      child: MyPoUpMenu(),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 24),
                child: MoviesList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

