import 'package:flutter/material.dart';

class RiskSummaryPanel extends StatelessWidget {
  const RiskSummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('System Status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // KPI Cards
          Row(
            children: [
              Expanded(child: _buildMetricCard('Active Alerts', '3', Colors.red)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('Monitored Roads', '1,250', Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildMetricCard('High Risk Zones', '12', Colors.orange)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('Sensors Online', '98%', Colors.green)),
            ],
          ),
          const SizedBox(height: 24),
          
          // Emergency Priority List
          const Text('Emergency Priority List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildPriorityItem(
            title: 'Village A Access Road',
            subtitle: 'Red Risk • 1,200 residents • Road Blocked',
            icon: Icons.warning_rounded,
            color: Colors.red,
          ),
          _buildPriorityItem(
            title: 'Hospital Route (NH-40)',
            subtitle: 'Orange Risk • Active slope movement',
            icon: Icons.local_hospital,
            color: Colors.orange,
          ),
          _buildPriorityItem(
            title: 'Bridge C',
            subtitle: 'Yellow Risk • Rising stream level',
            icon: Icons.water,
            color: Colors.yellow.shade700,
          ),

          const SizedBox(height: 24),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.campaign),
              label: const Text('ISSUE DISTRICT WARNING'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPriorityItem({required String title, required String subtitle, required IconData icon, required Color color}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
