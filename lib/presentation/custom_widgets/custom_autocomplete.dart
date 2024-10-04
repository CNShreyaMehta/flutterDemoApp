import 'package:flutter/material.dart';

class CustomAutocomplete<T extends Object> extends StatelessWidget {
  final List<T> options;
  final String Function(T) displayStringForOption;
  final ValueChanged<T> onSelected;
  final String labelText;
  final InputDecoration? decoration;

  const CustomAutocomplete({
    super.key,
    required this.options,
    required this.displayStringForOption,
    required this.onSelected,
    this.labelText = "Select",
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return  Iterable<T>.empty();
        }
        return options.where((T option) {
          return displayStringForOption(option)
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: displayStringForOption,
      onSelected: onSelected,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: decoration ??
              InputDecoration(
                labelText: labelText,
                border: const OutlineInputBorder(),
              ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<T> onSelected,
          Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final T option = options.elementAt(index);

                return ListTile(
                  title: Text(displayStringForOption(option)),
                  onTap: () {
                    onSelected(option);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
