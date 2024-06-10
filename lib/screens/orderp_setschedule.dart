// screens/orderp_setschedule.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'orderp_showstasiun.dart';
import 'orderp_showtrip.dart';  // pastikan path ini sesuai

class OrderScheduleSet extends StatefulWidget {
  final String? destination;

  const OrderScheduleSet({Key? key, this.destination}) : super(key: key);

  @override
  _OrderScheduleSetState createState() => _OrderScheduleSetState();
}

class _OrderScheduleSetState extends State<OrderScheduleSet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController _passengerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _originController.text = '';
    _destinationController.text = widget.destination ?? '';
  }

  void _swapStations() {
    String temp = _originController.text;
    setState(() {
      _originController.text = _destinationController.text;
      _destinationController.text = temp;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectStation(bool isOrigin) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => isOrigin ? ShowStasiunAwal() : ShowStasiunTujuan(),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (isOrigin) {
          _originController.text = result['nama'];
        } else {
          _destinationController.text = result['nama'];
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderShowTrip(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Tiket'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: IntrinsicHeight(
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), 
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _originController,
                                readOnly: true,
                                decoration: InputDecoration(labelText: 'Stasiun Asal'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Mohon isi stasiun asal';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  _selectStation(true);
                                },
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _swapStations,
                                child: Icon(Icons.swap_vert),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(50, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  foregroundColor: Color(0xFF797EF6),
                                ),
                              ),
                              TextFormField(
                                controller: _destinationController,
                                readOnly: true,
                                decoration: InputDecoration(labelText: 'Stasiun Tujuan'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Mohon isi stasiun tujuan';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  _selectStation(false);
                                },
                              ),
                              SizedBox(height: 32),
                              TextFormField(
                                controller: _dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Tanggal Pergi',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Mohon isi tanggal pergi';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  _selectDate(context);
                                },
                              ),
                              SizedBox(height: 32),
                              TextFormField(
                                controller: _passengerController,
                                decoration: InputDecoration(labelText: 'Jumlah Penumpang (Dewasa)'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Mohon isi jumlah penumpang';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Mohon isi dengan angka yang valid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: _submitForm,
                                child: Text(
                                  'CARI TIKET KERETA API',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  backgroundColor: Color(0xFF797EF6),
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
