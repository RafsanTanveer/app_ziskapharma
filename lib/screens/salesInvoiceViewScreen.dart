import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:flutter/material.dart';

class Salesinvoiceviewscreen extends StatelessWidget {
  const Salesinvoiceviewscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController invoiceNoController = TextEditingController();
    TextEditingController customerNameController = TextEditingController();
    TextEditingController prdAmountController = TextEditingController();
    TextEditingController discountController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController vatController = TextEditingController();
    TextEditingController specialDiscountController = TextEditingController();
    TextEditingController billAmountController = TextEditingController();

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
                      hint: 'hint',
                      title: "Invoice No."),
                  CustomTextFormField(
                      controller: customerNameController,
                      hint: 'hint',
                      title: "Customer Name"),
                  CustomTextFormField(
                      controller: prdAmountController,
                      hint: 'hint',
                      title: "Prd. Amount"),
                  CustomTextFormField(
                      controller: discountController,
                      hint: 'hint',
                      title: "Discount"),
                  CustomTextFormField(
                      controller: amountController,
                      hint: 'hint',
                      title: "Amount"),
                  CustomTextFormField(
                      controller: vatController, hint: 'hint', title: "VAT"),
                  CustomTextFormField(
                      controller: specialDiscountController,
                      hint: 'hint',
                      title: "Special Discount"),
                  CustomTextFormField(
                      controller: billAmountController,
                      hint: 'hint',
                      title: "Bill Amount"),
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
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            onPressed: () =>
                                {Navigator.pop(context, '/salesmgt')},
                            child: Text(
                              'Back',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .020),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
