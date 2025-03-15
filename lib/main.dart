import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

// for dark mode
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      // material app gives you some key configuration settings, that you can make here that influence your entire app like "theme"
      // theme --> one central place in which we could set up certain styles, and those will automatically
      // get applied to certain widgets or could at least be referenced from inside our different widgets
      // so for example we don't have to copy and paste color definitions across different parts of our app.
      // we can control, in detail which color different widget in you app will have,
      // and which text styles you want to be to use
      // when we use ThemeData() like this and passing some configuration to those parentheses,
      // you are actually telling flutter that you are setting up the entire theme from scratch,
      // which means that you should configure all these aspects that make up you application,
      // you should configure all text styles you could possibly use, you should configure all other styles,
      // that might be used by any widget in your app, like color
      theme: ThemeData().copyWith(
        // scaffoldBackgroundColor: const Color.fromARGB(255, 220, 189, 252),
        // in this central place where i can make certain adjustments like scaffoldBackground, when using it, it will automatically apply to all the widgets that are interested in that settings
        // in this case the scaffoldBackground, and if i have an app with multiple screen, with multiple instances of scaffold widget,
        // all those screens would use this color
        // --------------------------------------------------------------------------------
        // colorScheme --> the idea is you define one color scheme and flutter then infers colors,
        // to be precise for different widgets.
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        // set up all cards style in the app
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // we can create a style object manually by using ButtonStyle() --> to have full control over how the button looks,
          // or we could use ElevatedButton.styleFrom --> uses flutter default styling and then allows us to override some selected style
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        // change all texts style
        // we could use TextTheme() to create text theme from the ground up and then target the different kinds of text
        // you might be using in your app manually here, or
        // you can use and create ThemeData()
        textTheme: ThemeData().textTheme.copyWith(
              // the title in the app bar
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      // darkTheme --> for dark theme, .dark() --> to get a lot of default dark mode settings and configurations
      // so we don't have adjust every thing manually to get dark mode to work
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        // set up all cards style in the app
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // we can create a style object manually by using ButtonStyle() --> to have full control over how the button looks,
          // or we could use ElevatedButton.styleFrom --> uses flutter default styling and then allows us to override some selected style
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),

      // themeMode --> to control which theme can be used "dark mode" or "light mode"
      // themeMode.system --> to get the same mode of the current system
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
