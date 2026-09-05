import 'package:dcc_rpg_crawler_generator/viewmodel/filter_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterData>(
      builder: (context, value, child) {
        return Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(height: 20),
                RadioGroup<int>(
                  groupValue: value.genderOption,
                  onChanged: (int? selected) {
                    setState(() {
                      value.setGender(selected);
                    });
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          'Male',
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Radio<int>(
                          value: 1,
                          fillColor: WidgetStateProperty.all<Color>(Colors.red),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Female',
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Radio<int>(
                          value: 2,
                          fillColor: WidgetStateProperty.all<Color>(Colors.red),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Either',
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Radio<int>(
                          value: 3,
                          fillColor: WidgetStateProperty.all<Color>(Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
