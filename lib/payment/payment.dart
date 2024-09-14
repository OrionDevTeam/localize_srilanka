import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:localize_sl/colorpalate.dart';

class CardFormPage extends StatefulWidget {
  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  TextStyle style1 = const TextStyle(color: Colors.black, fontSize: 16.0);
  TextStyle style2 = const TextStyle(color: ColorPalette.grey2, fontSize: 16.0);

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.black, width: 0.8),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {
              print(creditCardBrand);
            },
            bankName: 'Localize Sri Lanka',
            obscureCardCvv: true,
            obscureCardNumber: true,
            isHolderNameVisible: true,
            isSwipeGestureEnabled: true,
            cardType: CardType.mastercard,
            glassmorphismConfig: Glassmorphism(
              blurX: 0.0,
              blurY: 0.0,
              gradient: LinearGradient(
                colors: [ColorPalette.green, ColorPalette.green2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          CreditCardForm(
            formKey: formKey,
            obscureCvv: true,
            obscureNumber: true,
            isHolderNameVisible: true,
            isCardNumberVisible: true,
            isExpiryDateVisible: true,
            cardNumber: cardNumber,
            cvvCode: cvvCode,
            cardHolderName: cardHolderName,
            expiryDate: expiryDate,
            inputConfiguration: InputConfiguration(
              cardNumberDecoration: InputDecoration(
                labelText: 'Number',
                hintText: 'XXXX XXXX XXXX XXXX',
                labelStyle: style1,
                hintStyle: style2,
                focusedBorder: border,
                enabledBorder: border,
              ),
              expiryDateDecoration: InputDecoration(
                labelText: 'Expired Date',
                hintText: 'XX/XX',
                labelStyle: style1,
                hintStyle: style2,
                focusedBorder: border,
                enabledBorder: border,
              ),
              cvvCodeDecoration: InputDecoration(
                labelText: 'CVV',
                hintText: 'XXX',
                labelStyle: style1,
                hintStyle: style2,
                focusedBorder: border,
                enabledBorder: border,
              ),
              cardHolderDecoration: InputDecoration(
                labelText: 'Card Holder',
                labelStyle: style1,
                hintStyle: style2,
                focusedBorder: border,
                enabledBorder: border,
              ),
            ),
            onCreditCardModelChange: onCreditCardModelChange,
          ),
          const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     if (formKey.currentState!.validate()) {
          //       print('Form Validated');
          //     }
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: ColorPalette.green2,
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: const Text(
          //     'Apply Now',
          //     style: TextStyle(color: Colors.white, fontSize: 16),
          //   ),
          // ),
        ],
      ),
    );
  }
}