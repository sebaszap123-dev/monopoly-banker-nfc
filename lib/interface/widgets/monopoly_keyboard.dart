import 'package:flutter/material.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';
import 'package:monopoly_banker/interface/widgets/numeric_button.dart';

/// A quick example "keyboard" widget for Numeric.
class MonopolyTerminal extends StatefulWidget implements PreferredSizeWidget {
  const MonopolyTerminal({
    Key? key,
  }) : super(key: key);

  @override
  State<MonopolyTerminal> createState() => _MonopolyTerminalState();

  @override
  Size get preferredSize => const Size.fromHeight(400);
}

class _MonopolyTerminalState extends State<MonopolyTerminal> {
  final TextEditingController controller = TextEditingController();

  void _onTapNumber(String value) {
    final currentValue = controller.text;
    // Limitar a 2 decimales después del punto
    if (currentValue.contains('.') && currentValue.split('.')[1].length >= 2) {
      return;
    }
    final temp = currentValue + value;
    controller.text = temp;
  }

  void _onDot() {
    final currentValue = controller.text.replaceAll(".", "");
    // Permitir solo un punto decimal
    if (!currentValue.contains('.')) {
      final temp = '$currentValue.';
      controller.text = temp;
    }
  }

  void _onTapC() => controller.clear();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      width: widget.preferredSize.width,
      color: const Color(0xFF313131),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Ingresa una cantidad',
                hintStyle: TextStyle(color: Colors.black),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              textAlign: TextAlign.center,
              controller: controller,
              enabled: false,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 5),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                ...TriggerType.values
                    .map((e) => MonopolyTriggerButton(onTap: () {}, type: e)),
                ...List.generate(
                  9,
                  (index) => MonopolyNumericButton(
                    number: index + 1,
                    onTap: () => _onTapNumber('${index + 1}'),
                  ),
                ),
                _buildButton(text: 'C', color: Colors.black),
                MonopolyNumericButton(
                    onTap: () => _onTapNumber('0'), number: 0),
                _buildButton(text: ".", color: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    Color? color,
  }) =>
      BaseButton(
        text: text,
        color: color,
        onTap: () => text == 'C' ? _onTapC() : _onDot(),
      );
}
