import 'package:bloc/bloc.dart';
import 'package:popular_movies_flutter/utils/enums.dart';
part 'sort_options_state.dart';

class SortOptionsCubit extends Cubit<SortOptionsState> {
  SortOptionsCubit() : super(SortOptionsState(selectedOption: SortOptions.name));

  void select(SortOptions selected) => emit(SortOptionsState(selectedOption: selected));
}
