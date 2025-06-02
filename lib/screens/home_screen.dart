import 'package:flutter/material.dart';
import '../widgets/monitoring_card.dart';
import '../widgets/header_widget.dart';
import '../services/email_service.dart';
import 'chart_screen.dart';

class HomeScreen extends StatelessWidget {
  final String recipientEmail =
      "iaryangupta21@gmail.com"; // Replace with your email

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            HeaderWidget(),

            // Alert Button
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _sendAlert(context),
                  icon: Icon(Icons.email, color: Colors.white),
                  label: Text(
                    'Send Alert Email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ),

            // Monitoring Cards Grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    MonitoringCard(
                      title: 'Water Level',
                      icon: Icons.water,
                      color: Colors.blue,
                      unit: 'cm',
                      fieldNumber: '1',
                      onTapped: () => _navigateToChart(
                        context,
                        'Water Level',
                        '1',
                        Colors.blue,
                      ),
                    ),
                    MonitoringCard(
                      title: 'Humidity',
                      icon: Icons.opacity,
                      color: Colors.green,
                      unit: '%',
                      fieldNumber: '2',
                      onTapped: () => _navigateToChart(
                        context,
                        'Humidity',
                        '2',
                        Colors.green,
                      ),
                    ),
                    MonitoringCard(
                      title: 'Temperature',
                      icon: Icons.thermostat,
                      color: Colors.orange,
                      unit: '°C',
                      fieldNumber: '3',
                      onTapped: () => _navigateToChart(
                        context,
                        'Temperature',
                        '3',
                        Colors.orange,
                      ),
                    ),
                    MonitoringCard(
                      title: 'Moisture',
                      icon: Icons.water_drop,
                      color: Colors.purple,
                      unit: '%',
                      fieldNumber: '4',
                      onTapped: () => _navigateToChart(
                        context,
                        'Moisture',
                        '4',
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _navigateToChart(
    BuildContext context,
    String title,
    String fieldNumber,
    Color color,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChartScreen(title: title, fieldNumber: fieldNumber, color: color),
      ),
    );
  }

  void _sendAlert(BuildContext context) async {
    try {
      await EmailService.sendAlertEmail(
        recipientEmail: recipientEmail,
        subject: 'Water Monitoring System Alert',
        body:
            '''
Dear Administrator,

This is an automated alert from the Water Monitoring System.

Please check the current water quality parameters and take necessary action if required.

Timestamp: ${DateTime.now().toString()}

Best regards,
Water Monitoring System
        ''',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email client opened successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
