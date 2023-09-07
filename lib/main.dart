import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceCalculator extends StatefulWidget {
  const PriceCalculator({Key? key}) : super(key: key);

  @override
  PriceCalculatorState createState() => PriceCalculatorState();
}

class PriceCalculatorState extends State<PriceCalculator> {
  double totalQuantity = 30000;
  double pricePerKg = 0.0;
  double transportationCost = 0.0;
  double totalCHA = 0.0;
  double currentDollarRate = 0.0;
  double customDollarRate = 0.0;
  TextEditingController customDollarRateController = TextEditingController();

  bool useCurrentDollarRate = false;

  double calculateTotalCost() {
    double totalCost =
        (totalQuantity * pricePerKg) + transportationCost + totalCHA;
    return totalCost;
  }

  double calculateTotalCostInDollar() {
    double totalCost = calculateTotalCost();
    if (!useCurrentDollarRate && customDollarRate != 0.0) {
      // Convert total cost from INR to USD
      totalCost /= customDollarRate;
    } else {
      totalCost /= currentDollarRate;
    }
    return totalCost;
  }

  void updateTotalQuantity(String value) {
    setState(() {
      try {
        totalQuantity = double.parse(value);
      } catch (e) {
        // Handle parsing error
        totalQuantity = 0.0;
      }
    });
  }

  void updatePricePerKg(String value) {
    setState(() {
      try {
        pricePerKg = double.parse(value);
      } catch (e) {
        // Handle parsing error
        pricePerKg = 0.0;
      }
    });
  }

  void updateTransportationCost(String value) {
    setState(() {
      try {
        transportationCost = double.parse(value);
      } catch (e) {
        // Handle parsing error
        transportationCost = 0.0;
      }
    });
  }

  void updateTotalCHA(String value) {
    setState(() {
      try {
        totalCHA = double.parse(value);
      } catch (e) {
        // Handle parsing error
        totalCHA = 0.0;
      }
    });
  }

  void fetchCurrentDollarRate() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dollarRate = data['rates']['INR'];

        setState(() {
          currentDollarRate = double.parse(dollarRate.toString());
        });
      }
    } catch (e) {
      // Handle error
      print('Error fetching dollar rate: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCurrentDollarRate();
  }

  @override
  void dispose() {
    customDollarRateController.dispose();
    super.dispose();
  }

  void updateCustomDollarRate(String value) {
    setState(() {
      try {
        customDollarRate = double.parse(value);
      } catch (e) {
        // Handle parsing error
        customDollarRate = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Quantity:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: updateTotalQuantity,
            ),
            const SizedBox(height: 16.0),
            const Text('Price per kg:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: updatePricePerKg,
            ),
            const SizedBox(height: 16.0),
            const Text('Transportation cost of Lorry:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: updateTransportationCost,
            ),
            const SizedBox(height: 16.0),
            const Text('Total CHA:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: updateTotalCHA,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: useCurrentDollarRate,
                  onChanged: (value) {
                    setState(() {
                      useCurrentDollarRate = value ?? false;
                    });
                  },
                ),
                const Text('Use current dollar rate'),
              ],
            ),
            if (!useCurrentDollarRate) ...[
              const SizedBox(height: 16.0),
              const Text('Custom Dollar Rate:'),
              TextField(
                keyboardType: TextInputType.number,
                controller: customDollarRateController,
                onChanged: updateCustomDollarRate,
              ),
            ],
            const SizedBox(height: 10.0),
            Text(
                'Total Cost in INR: ${calculateTotalCost().toStringAsFixed(2)}'),
            const SizedBox(height: 10.0),
            Text(
                'Total Cost in USD: ${(calculateTotalCostInDollar()).toStringAsFixed(2)}'),
            const SizedBox(height: 10.0),
            Text(
                'Total Cost per Ton in INR : ${(calculateTotalCost() / (totalQuantity / 1000)).toStringAsFixed(2)}'),
            const SizedBox(height: 10.0),
            Text(
                'Total Cost per Ton in USD : ${(calculateTotalCostInDollar() / (totalQuantity / 1000)).toStringAsFixed(2)}'),
            const SizedBox(height: 10.0),
            Text(
                'Exchange Rate: ${useCurrentDollarRate ? currentDollarRate.toStringAsFixed(2) : customDollarRate.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: PriceCalculator(),
    ),
  );
}
