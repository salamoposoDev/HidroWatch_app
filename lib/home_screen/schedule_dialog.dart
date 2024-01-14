import 'package:cctv_iot/home_screen/cubit/set_schedule_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleDialog extends StatefulWidget {
  const ScheduleDialog({
    super.key,
  });

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  final item = ['Time 1', 'Time 2', 'Time 3'];
  final value = ['time1', 'time2', 'time3'];
  String selectedValue = '';
  String selectedItem = '';
  String newTime = '';

  @override
  void initState() {
    selectedValue = value[0];
    selectedItem = item[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final setData = context.read<SetScheduleCubit>();
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                isDense: true,
                hint: Text(selectedItem),
                items: List.generate(item.length, (index) {
                  return DropdownMenuItem(
                    child: Text(item[index]),
                    value: value[index],
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                    print(value);
                    switch (value) {
                      case 'time1':
                        selectedItem = item[0];
                        break;
                      case 'time2':
                        selectedItem = item[1];
                        break;
                      case 'time3':
                        selectedItem = item[2];
                        break;
                    }
                  });
                },
              ),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.clear)),
            ],
          ),
          CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              onTimerDurationChanged: (value) {
                int hours = value.inHours;
                int minutes = (value.inMinutes % 60);

                newTime = '$hours:$minutes';
              }),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    setData.setSchedule(key: selectedValue, schedule: newTime);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'save',
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
