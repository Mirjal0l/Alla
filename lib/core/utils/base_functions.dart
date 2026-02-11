part of 'utils.dart';

final String defaultSystemLocale = Platform.localeName.split('_').first;

String get defaultLocale => switch(defaultSystemLocale) {
  'ru' => 'ru',
  'en' => 'en',
  'uz' => 'uz',
  _ => 'ru',
};
