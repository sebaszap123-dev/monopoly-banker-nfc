import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monopoly_banker/config/utils/banker_alerts.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_trigger_button.dart';
import 'package:monopoly_banker/interface/widgets/numeric_button.dart';
import 'package:monopoly_banker/interface/widgets/transaction_button.dart';

/// A quick example "keyboard" widget for Numeric.
class MonopolyTerminal extends StatefulWidget implements PreferredSizeWidget {
  const MonopolyTerminal({
    super.key,
  });

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

  String moneyValue = 'M';
  MoneyValue currentType = MoneyValue.millon;

  void onTapSpecialButton(MoneyValue type) async {
    switch (type) {
      case MoneyValue.millon:
        moneyValue = 'M';
        break;

      case MoneyValue.miles:
        moneyValue = 'K';
        break;

      case MoneyValue.salida:
        getIt<MonopolyElectronicoBloc>().add(PassExitEvent());
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
        getIt<MonopolyElectronicoBloc>().add(AddPlayerMoneyEvent(
            type: currentType, money: double.parse(controller.text)));
        break;

      case Transactions.substract:
        getIt<MonopolyElectronicoBloc>().add(SubstractMoneyEvent(
            type: currentType, money: double.parse(controller.text)));
        break;

      case Transactions.fromPlayers:
        getIt<MonopolyElectronicoBloc>()
            .add(PayPlayersEvent(double.parse(controller.text), currentType));
        break;
    }
    controller.clear();
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
                  moneyValue,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: moneyValue == 'M' ? Colors.red : Colors.blue,
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
                ...MoneyValue.values.map((e) => MonopolyTriggerButton(
                      onTap: () => onTapSpecialButton(e),
                      type: e,
                    )),
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
                ...Transactions.values.map((e) => TransactionButton(
                    transactionType: e, onTap: () => onTransactions(e)))
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
