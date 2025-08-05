class EnterPasswordProps {
  EnterPasswordProps({
    required this.title,
    required this.isLoading,
    required this.isDisabled,
    required this.isAutofocus,
  });

  final String? title;
  final bool isLoading;
  final bool isDisabled;
  final bool isAutofocus;
}
