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
      builder: (context, data, child) {
        return SingleChildScrollView(
          child: Container(
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
                  Row(
                    children: [
                      const Text('Gender', style: TextStyle(color: Colors.red)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(height: 1.0, color: Colors.red),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  RadioGroup<int>(
                    groupValue: data.genderOption,
                    onChanged: (int? selected) {
                      setState(() {
                        data.setGender(selected);
                      });
                    },
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          fillColor: WidgetStateProperty.all<Color>(
                            Colors.grey,
                          ),
                        ),
                        Text('Male', style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 20),
                        Radio<int>(
                          value: 2,
                          fillColor: WidgetStateProperty.all<Color>(
                            Colors.grey,
                          ),
                        ),
                        Text('Female', style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 20),
                        Radio<int>(
                          value: 3,
                          fillColor: WidgetStateProperty.all<Color>(
                            Colors.grey,
                          ),
                        ),
                        Text('Both', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Regions',
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(height: 1.0, color: Colors.red),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('All', style: TextStyle(color: Colors.red)),
                      Checkbox(
                        value: data.allChecked,
                        activeColor: Colors.red,
                        onChanged: (_) {
                          setState(() => data.toggleAllChecked());
                        },
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      for (var nationality in data.nationalities.entries)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: nationality.value,
                              activeColor: Colors.grey,
                              onChanged: (value) {
                                setState(() {
                                  data.nationalities[nationality.key] = value!;
                                });
                              },
                            ),
                            Text(
                              nationality.key,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
