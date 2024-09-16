import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/model/money.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';
import 'package:monopoly_banker/interface/widgets/numeric_button.dart';
import 'package:monopoly_banker/interface/widgets/transaction_button.dart';

enum ButtonType { clear, dot, numeric, transaction }

/// A quick example "keyboard" widget for Numeric.
class MonopolyTerminal extends StatefulWidget implements PreferredSizeWidget {
  const MonopolyTerminal({
    Key? key,
  }) : super(key: key);

  @override
  State<MonopolyTerminal> createState() => _MonopolyTerminalState();

  @override
  Size get preferredSize => const Size.fromHeight(450);
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

  Money money = Money(type: MoneyType.thousands, value: 0);

  MoneyActionSpecial currentType = MoneyActionSpecial.millon;

  void onTapSpecialButton(MoneyActionSpecial type) async {
    switch (type) {
      case MoneyActionSpecial.millon:
        money = money..type = MoneyType.million;
        break;

      case MoneyActionSpecial.miles:
        money = money..type = MoneyType.thousands;
        break;

      case MoneyActionSpecial.salida:
        getIt<ElectronicGameV2Bloc>().add(PassExitEvent());
        break;
    }
    currentType = type;
    setState(() {});
  }

  void onTransactions(Transactions data) {
    if (controller.text.isEmpty) {
      data == Transactions.fromPlayers ? BankerAlerts.addMoneyToPay() : null;
      return;
    }
    switch (data) {
      case Transactions.add:
        getIt<ElectronicGameV2Bloc>().add(AddPlayerMoneyEvent(
            money: money..value = double.parse(controller.text)));
        break;

      case Transactions.substract:
        getIt<ElectronicGameV2Bloc>().add(SubtractMoneyEvent(
            money: money..value = double.parse(controller.text)));
        break;

      case Transactions.fromPlayers:
        getIt<ElectronicGameV2Bloc>()
            .add(PayPlayersEvent(money..value = double.parse(controller.text)));
        break;
    }
    controller.clear();
  }

  Widget buildButton(ButtonType buttonType,
      {int? number, Transactions? transactionType}) {
    switch (buttonType) {
      case ButtonType.clear:
        return _buildButton(text: 'C', color: Colors.black, type: buttonType);
      case ButtonType.dot:
        return _buildButton(text: ".", color: Colors.black, type: buttonType);
      case ButtonType.numeric:
        return MonopolyNumericButton(
            onTap: () => _onTapNumber('$number'), number: number!);
      case ButtonType.transaction:
        return TransactionButton(
            transactionType: transactionType!,
            onTap: () => onTransactions(transactionType));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      width: widget.preferredSize.width,
      color: const Color(0xFF313131),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '0',
                hintStyle: const TextStyle(color: Colors.black),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                suffixIcon: Text(
                  money.value.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: money.type == MoneyType.million
                        ? Colors.red
                        : Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
                ...MoneyActionSpecial.values.map((e) => MonopolyTriggerButton(
                      onTap: () => onTapSpecialButton(e),
                      type: e,
                    )),
                ...List.generate(
                  9,
                  (index) => buildButton(ButtonType.numeric, number: index + 1),
                ),
                buildButton(ButtonType.clear),
                buildButton(ButtonType.numeric, number: 0),
                buildButton(ButtonType.dot),
                ...Transactions.values.map((e) =>
                    buildButton(ButtonType.transaction, transactionType: e)),
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
    required ButtonType type,
  }) =>
      BaseButton(
        text: text,
        color: color,
        onTap: () => type == ButtonType.clear ? _onTapC() : _onDot(),
      );
}
