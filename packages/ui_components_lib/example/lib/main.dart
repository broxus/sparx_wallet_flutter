import 'package:example/stories/stories.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

void main() {
  runApp(const StoryWidget());
}

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      wrapperBuilder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(extensions: [everPredefinedTheme()]),
          home: child,
        );
      },
      initialStory: 'Git log',
      stories: [
        Story(
          name: 'Git log',
          builder: (_) => const GitLog(),
        ),
        Story(
          name: 'Widgets/Buttons',
          builder: (_) => const ButtonsStory(),
        ),
        Story(
          name: 'Colors',
          builder: (_) => const ColorsStory(),
        ),
      ],
    );
  }
}
