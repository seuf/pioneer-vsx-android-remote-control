import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pioneer_vsx_remote_control/src/settings/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config_loader.dart';

class RemoteControl extends StatefulWidget {
  const RemoteControl({super.key});

  @override
  RemoteControlState createState() => RemoteControlState();
}

class RemoteControlState extends State<RemoteControl> {
  List<Map<String, String>> buttons = [];

  @override
  void initState() {
    super.initState();
    loadConfig().then((config) {
      // buttons = config;
      // _loadPreferences();
      setState(() {
        buttons = config;
      });
      _loadPreferences();
    });
    //_loadPreferences();
    // print(buttons[0]['endpoint']);
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('ip_address : ${prefs.getString('ip_address')}');
    for (var button in buttons) {
      print('button ${button['name']} : ${button['endpoint']}');
      button['url'] = 'http://${prefs.getString('ip_address') ?? '192.168.1.23'}/EventHandler.asp?WebToHostItem=${button['endpoint']}';
    }
    setState(() {
      buttons = buttons;
    });
    // setState(() {
    //   buttons.forEach((button) {
    //     print('button ${button['name']} : ${button['endpoint']}');
    //     button['url'] = 'http://${prefs.getString('ip_address') ?? '192.168.1.23'}/EventHandler.asp?WebToHostItem=${button['endpoint']}';
    //   });
    // });
  }

  void sendCommand(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Command sent successfully');
        }
      } else {
        if (kDebugMode) {
          print('Failed to send command');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending command: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pioneer VSX Remote Control'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(onSave: _loadPreferences),
                ),
              );
            },
          ),
        ],
      ),
      body: buttons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildButton(buttons, "Power"),
                  const SizedBox(height: 20),
                  // Volume Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton(buttons, 'Volume -'),
                      const SizedBox(width: 20),
                      buildButton(buttons, 'Volume +'),
                      const SizedBox(width: 20),
                      buildButton(buttons, 'Mute'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Source Controls
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      buildButton(buttons, 'Source CD'),
                      buildButton(buttons, 'Source Radio'),
                      buildButton(buttons, 'Source BT'),
                      buildButton(buttons, 'Source HDMI'),
                      buildButton(buttons, 'Source BD'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Navigation Controls
                  Column(
                    children: [
                      buildButton(buttons, 'Nav Up'),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildButton(buttons, 'Nav Left'),
                          const SizedBox(width: 5),
                          buildButton(buttons, 'Enter'),
                          const SizedBox(width: 5),
                          buildButton(buttons, 'Nav Right'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      buildButton(buttons, 'Nav Down'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Power Control
                  buildButton(buttons, 'Back'),
                ],
              ),
            ),
    );
  }

  Widget buildButton(List<Map<String, String>> buttons, String buttonName) {
    final button = buttons.firstWhere(
      (button) => button['name'] == buttonName,
      orElse: () => {'name': '', 'endpoint': '', 'icon': ''},
    );

    IconData icon;
    switch (button['icon']) {
      case 'power_settings_new':
        icon = Icons.power_settings_new;
        break;
      case 'undo':
        icon = Icons.undo;
      case 'volume_up':
        icon = Icons.volume_up;
      case 'volume_down':
        icon = Icons.volume_down;
      case 'volume_off':
        icon = Icons.volume_off;
      case 'album':
        icon = Icons.album;
      case 'radio':
        icon = Icons.radio;
      case 'bluetooth':
        icon = Icons.bluetooth;
      case 'settings_input_hdmi':
        icon = Icons.settings_input_hdmi;
      case 'tv':
        icon = Icons.tv;
      case 'keyboard_arrow_up':
        icon = Icons.keyboard_arrow_up;
      case 'keyboard_arrow_down':
        icon = Icons.keyboard_arrow_down;
      case 'keyboard_arrow_left':
        icon = Icons.keyboard_arrow_left;
      case 'keyboard_arrow_right':
        icon = Icons.keyboard_arrow_right;
      case 'adjust':
        icon = Icons.adjust;
      case 'spatial_audio':
        icon = Icons.spatial_audio;
      default:
        icon = Icons.help_outline; // Default icon if none matches
    }

    return ElevatedButton.icon(
      onPressed: button['url']!.isNotEmpty
          ? () => sendCommand(button['url']!)
          : null,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(const Size.fromWidth(60)),

        backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFFCFCFD)),
        foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFF36395A)),
        shadowColor: WidgetStateProperty.all<Color>(
            const Color(0xFF2D2342).withOpacity(0.4)),
        elevation: WidgetStateProperty.all<double>(4.0),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 5.0)),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 18,
              color: Color(0xFF36395A),
              height: 1),
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return const Color(0xFFDDDDDD); // Color when the button is pressed
            }
            return const Color(0xFFDDDDDD);
          },
        ),
      ),
      icon: Icon(icon),
      label: const Text(''), // Text(button['name']!),
      // child: Icon(icon),
      // child: Text(button['name']!),
    );
  }
}