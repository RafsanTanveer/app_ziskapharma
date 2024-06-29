import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SalesInvoiceViewScreen extends HookWidget {
  const SalesInvoiceViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invoiceNoController = useTextEditingController();
    final customerNameController = useTextEditingController();
    final prdAmountController = useTextEditingController();
    final discountController = useTextEditingController();
    final amountController = useTextEditingController();
    final vatController = useTextEditingController();
    final specialDiscountController = useTextEditingController();
    final billAmountController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Info Edit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 15,
          interactive: true,
          radius: Radius.circular(20),
          child: Container(
            margin: EdgeInsets.only(top: 20.0, left: 15, right: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: invoiceNoController,
                    hint: 'Invoice No.',
                    title: "Invoice No.",
                  ),
                  CustomTextFormField(
                    controller: customerNameController,
                    hint: 'Customer Name',
                    title: "Customer Name",
                  ),
                  CustomTextFormField(
                    controller: prdAmountController,
                    hint: 'Prd. Amount',
                    title: "Prd. Amount",
                  ),
                  CustomTextFormField(
                    controller: discountController,
                    hint: 'Discount',
                    title: "Discount",
                  ),
                  CustomTextFormField(
                    controller: amountController,
                    hint: 'Amount',
                    title: "Amount",
                  ),
                  CustomTextFormField(
                    controller: vatController,
                    hint: 'VAT',
                    title: "VAT",
                  ),
                  CustomTextFormField(
                    controller: specialDiscountController,
                    hint: 'Special Discount',
                    title: "Special Discount",
                  ),
                  CustomTextFormField(
                    controller: billAmountController,
                    hint: 'Bill Amount',
                    title: "Bill Amount",
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            elevation: 3,
                            maximumSize: Size(150, 150),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, '/salesmgt');
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  MediaQuery.of(context).size.height * .020,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
