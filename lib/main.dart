/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';

void main() => runApp(TipCalculatorApp());

// ignore: use_key_in_widget_constructors
class TipCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(title: 'Tip Calculator'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var billAmount = 0;
  var tipPercentage = 15;

  final _billAmountEditingController = TextEditingController(text: '0');
  final _tipEditingController = TextEditingController(text: '15');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _billAmountEditingController,
              decoration: const InputDecoration(
                prefixText: '\$',
                labelText: 'Bill Amount',
                hintText: 'eg. 50',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    billAmount = int.parse(value);
                  });
                }
              },
            ),
            TextField(
              controller: _tipEditingController,
              decoration: const InputDecoration(
                labelText: 'Tip %',
                hintText: 'eg. 15',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    tipPercentage = int.parse(value);
                  });
                }
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Tip amount: \$${_getCalculatedTip()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Total amount: \$${_getTotalBill()}',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }

  double _getCalculatedTip() => billAmount * tipPercentage / 100;

  double _getTotalBill() => billAmount + _getCalculatedTip();
}
