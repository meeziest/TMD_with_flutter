import 'package:popular_movies_flutter/localization/localiztion_service.dart';

enum TKeys{
  appTitle,
  sortByName,
  sortByDate,
  sortByRating,
  aboutMovie,
  releaseDate,
  budget,
  errorMessage,
  tryAgain,
}

extension TKeysExtention on TKeys {
  String get _string => toString().split('.')[1];

  String translate(context) {
    return LocalizationService.of(context).translate(_string) ?? '';
  }
}