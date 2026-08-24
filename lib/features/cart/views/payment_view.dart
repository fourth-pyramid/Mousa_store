// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';

// import '../../../core/utils/responsive_helper.dart';
// import '../../../core/utils/widgets/custom_button.dart';
// import '../../../l10n/app_localizations.dart';

// class PaymentView extends StatefulWidget {
//   const PaymentView({super.key});

//   @override
//   State<PaymentView> createState() => _PaymentViewState();
// }

// class _PaymentViewState extends State<PaymentView> {
//   final ValueNotifier<String> _cardNumberNotifier = ValueNotifier<String>('');
//   final ValueNotifier<String> _expiryDateNotifier = ValueNotifier<String>('');
//   final ValueNotifier<String> _cardHolderNameNotifier = ValueNotifier<String>(
//     '',
//   );
//   final ValueNotifier<String> _cvvCodeNotifier = ValueNotifier<String>('');
//   final ValueNotifier<bool> _isCvvFocusedNotifier = ValueNotifier<bool>(false);

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _cardNumberNotifier.dispose();
//     _expiryDateNotifier.dispose();
//     _cardHolderNameNotifier.dispose();
//     _cvvCodeNotifier.dispose();
//     _isCvvFocusedNotifier.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Scaffold(
//       appBar: AppBar(title: Text(localizations.checkout_text)),
//       body: Directionality(
//         textDirection: TextDirection.ltr,
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     /// كارت الفيزا
//                     ValueListenableBuilder<bool>(
//                       valueListenable: _isCvvFocusedNotifier,
//                       builder: (context, isCvvFocused, _) =>
//                           ValueListenableBuilder<String>(
//                             valueListenable: _cardNumberNotifier,
//                             builder: (context, cardNumber, _) =>
//                                 ValueListenableBuilder<String>(
//                                   valueListenable: _expiryDateNotifier,
//                                   builder: (context, expiryDate, _) =>
//                                       ValueListenableBuilder<String>(
//                                         valueListenable:
//                                             _cardHolderNameNotifier,
//                                         builder: (context, cardHolderName, _) =>
//                                             ValueListenableBuilder<String>(
//                                               valueListenable: _cvvCodeNotifier,
//                                               builder: (context, cvvCode, _) =>
//                                                   CreditCardWidget(
//                                                     labelCardHolder: localizations
//                                                         .card_holder_name_text,
//                                                     cardNumber: cardNumber,
//                                                     expiryDate: expiryDate,
//                                                     cardHolderName:
//                                                         cardHolderName,
//                                                     cvvCode: cvvCode,
//                                                     showBackView: isCvvFocused,
//                                                     obscureCardNumber: false,
//                                                     obscureCardCvv: false,
//                                                     isHolderNameVisible: true,
//                                                     onCreditCardWidgetChange:
//                                                         (brand) {},
//                                                   ),
//                                             ),
//                                       ),
//                                 ),
//                           ),
//                     ),

//                     /// نموذج البيانات
//                     CreditCardForm(
//                       formKey: formKey,
//                       obscureCvv: true,
//                       cardNumber: _cardNumberNotifier.value,
//                       expiryDate: _expiryDateNotifier.value,
//                       cardHolderName: _cardHolderNameNotifier.value,
//                       cvvCode: _cvvCodeNotifier.value,

//                       cvvValidator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return localizations.enter_cvv_text;
//                         } else if (value.length != 3) {
//                           return localizations.three_digits_only_text;
//                         }
//                         return null;
//                       },

//                       inputConfiguration: InputConfiguration(
//                         cardNumberDecoration: InputDecoration(
//                           labelText: localizations.card_number_text,
//                         ),
//                         expiryDateDecoration: InputDecoration(
//                           labelText: localizations.expiry_date_text,
//                           hintText: 'MM/YY',
//                         ),
//                         cardHolderDecoration: InputDecoration(
//                           labelText: localizations.card_holder_name_text,
//                         ),
//                         cvvCodeDecoration: const InputDecoration(
//                           labelText: 'CVV',
//                         ),
//                       ),

//                       onCreditCardModelChange: (CreditCardModel data) {
//                         _cardNumberNotifier.value = data.cardNumber;
//                         _expiryDateNotifier.value = data.expiryDate;
//                         _cardHolderNameNotifier.value = data.cardHolderName;
//                         _cvvCodeNotifier.value = data.cvvCode;
//                         _isCvvFocusedNotifier.value = data.isCvvFocused;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsetsDirectional.symmetric(
//                 horizontal: 16.0.w,
//                 vertical: 20.h,
//               ),
//               child: CustomButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           localizations.payment_success_message_text,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 text: Text(localizations.pay_now_button_text),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
