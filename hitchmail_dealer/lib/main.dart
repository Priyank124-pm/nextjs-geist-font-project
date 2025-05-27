import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/business_hours_page.dart';
import 'screens/parcel_history_page.dart';
import 'screens/payment_page.dart';
import 'screens/pin_input_page.dart';

void main() {
  runApp(HitchmailDealerApp());
}

class HitchmailDealerApp extends StatefulWidget {
  @override
  _HitchmailDealerAppState createState() => _HitchmailDealerAppState();
}

class _HitchmailDealerAppState extends State<HitchmailDealerApp> {
  bool onboardingComplete = false;

  void _completeOnboarding() {
    setState(() {
      onboardingComplete = true;
    });
  }

  void _handleScanIn() {
    // TODO: Implement scan in logic
    print('Scan In triggered');
  }

  void _handleScanOut() {
    // TODO: Implement scan out logic
    print('Scan Out triggered');
  }

  void _handlePinEntered(String pin) {
    // TODO: Validate PIN and update tracking system
    print('PIN entered: \$pin');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitchmail Dealer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: onboardingComplete
          ? MainApp()
          : OnboardingPage(onComplete: _completeOnboarding),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  final VoidCallback onComplete;

  OnboardingPage({required this.onComplete});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? address;
  String? governmentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dealer Onboarding'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => name = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your address' : null,
                onSaved: (value) => address = value,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement government ID photo upload
                },
                child: Text(governmentId == null
                    ? 'Upload Government ID'
                    : 'Government ID Uploaded'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onComplete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Onboarding Complete')),
                    );
                  }
                },
                child: Text('Complete Onboarding'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePage(
      onScanIn: () => print('Scan In'),
      onScanOut: () => print('Scan Out'),
    ),
    BusinessHoursPage(),
    ParcelHistoryPage(),
    PaymentPage(),
    PinInputPage(
      onPinEntered: (pin) => print('PIN entered: \$pin'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Business Hours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'PIN Input',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
