import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies_flutter/bloc/sort_options_bloc/sort_options_cubit.dart';
import 'package:popular_movies_flutter/localization/tKeys.dart';
import 'package:popular_movies_flutter/utils/constants.dart';
import 'package:popular_movies_flutter/utils/enums.dart';
import 'package:popular_movies_flutter/utils/icons.dart';

class MyPoUpMenu extends StatefulWidget {
  const MyPoUpMenu({Key? key}) : super(key: key);

  @override
  State<MyPoUpMenu> createState() => _MyPoUpMenuState();
}

class _MyPoUpMenuState extends State<MyPoUpMenu> {
  List<TKeys> options = <TKeys>[TKeys.sortByName,TKeys.sortByDate,TKeys.sortByRating];
  TKeys selectedItem = TKeys.sortByName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: AutoSizeText(
                selectedItem.translate(context),
                style: kSelectedItemTextStyle,
              minFontSize: 10,
              maxFontSize: 15,
              maxLines: 2,
            ),
          ),
          Expanded(
            flex: 2,
            child: Theme(
              data: Theme.of(context).copyWith(
              cardColor: Colors.white),
              child: PopupMenuButton<TKeys>(
                icon: CustomIcons.swapArrow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onSelected: (newValue) {
                  setState(() {
                    selectedItem = newValue;
                    if(selectedItem == options[0]){
                      context.read<SortOptionsCubit>().select(SortOptions.name);
                    }
                    else if(selectedItem == options[1]){
                      context.read<SortOptionsCubit>().select(SortOptions.date);
                    }
                    else if(selectedItem == options[2]){
                      context.read<SortOptionsCubit>().select(SortOptions.rating);
                    }
                  });
                },
                itemBuilder: (context) => options
                    .map((item) => PopupMenuItem<TKeys>(
                  value: item,
                  child: SizedBox(
                      width:100,
                      child: AutoSizeText(
                          item.translate(context),
                          maxFontSize: 15,
                          style: kDropDownItemsTextStyle)
                  ),
                ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
