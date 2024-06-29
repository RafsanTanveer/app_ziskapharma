import 'dart:convert';

import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/InvoiceModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import 'package:http/http.dart' as http;

class SalesInvoiceViewScreen extends HookWidget {
  const SalesInvoiceViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerSettingScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as CustomerSettingScreenArgs;

    final invoiceNoController = useTextEditingController();
    final customerNameController = useTextEditingController();
    final prdAmountController = useTextEditingController();
    final discountController = useTextEditingController();
    final amountController = useTextEditingController();
    final vatController = useTextEditingController();
    final specialDiscountController = useTextEditingController();
    final billAmountController = useTextEditingController();

    final invoiceInfo = useState<InvoiceModel?>(null);

    fetchInvoiceData(String vInvoiceNumber) async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_SalesInvoiceViewByApi?vInvoiceNumber=${vInvoiceNumber}');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          print(response.body);

          final jsonResponse = json.decode(response.body);
          final List<dynamic> table = jsonResponse['Table'];
          final Map<String, dynamic> data = table.first;
          invoiceInfo.value = InvoiceModel.fromJson(data);

          invoiceNoController.text = invoiceInfo!.value!.storeMainInvoiceNo;
          customerNameController.text =
              invoiceInfo!.value!.storeMainCustomerName;
          prdAmountController.text =
              invoiceInfo!.value!.storeMainTotalPrdAmount.toString();
          discountController.text =
              invoiceInfo!.value!.storeMainTotalDiscountAmount.toString();
          amountController.text =
              invoiceInfo!.value!.storeMainTotalPrdAmountAfterDiscount.toString();
          vatController.text =
              invoiceInfo!.value!.storeMainTotalVatAmount.toString();
          specialDiscountController.text = invoiceInfo!
              .value!.storeMainTotalSpecialDiscountAmount
              .toString();
          billAmountController.text =
              invoiceInfo!.value!.storeMainTotalBillAmount.toString();
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {}
    }

    useEffect(() {
     
      fetchInvoiceData(args.cpCode);
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invoice Approval',
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
