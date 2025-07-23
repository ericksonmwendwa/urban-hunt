import 'package:flutter/material.dart';

typedef RadioCallback = void Function(String value);

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.selected,
    required this.value,
    required this.label,
    required this.onChange,
  });

  final String selected;
  final String value;
  final String label;
  final RadioCallback onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(value),
      child: Row(
        children: <Widget>[
          Radio(
            value: value,
            groupValue: selected,
            onChanged: (value) => onChange(value.toString()),
            visualDensity: VisualDensity.comfortable,
            fillColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              return Theme.of(context).colorScheme.inverseSurface;
            }),
          ),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
