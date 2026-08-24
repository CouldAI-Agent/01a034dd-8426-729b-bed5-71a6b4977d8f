import 'package:flutter/material.dart';
import '../widgets/simulated_map.dart';
import '../widgets/risk_summary.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NER-SAFE Command Center', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_active), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
      floatingActionButton: isDesktop ? null : FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.report_problem),
        label: const Text('Field Report'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sidebar Navigation
        Container(
          width: 250,
          color: Colors.grey[100],
          child: Column(
            children: [
              _buildNavItem(Icons.dashboard, 'Dashboard', true),
              _buildNavItem(Icons.map, 'Live GIS Map', false),
              _buildNavItem(Icons.warning, 'Active Alerts', false),
              _buildNavItem(Icons.report, 'Field Reports', false),
              _buildNavItem(Icons.analytics, 'Analytics', false),
            ],
          ),
        ),
        // Main Content (Map)
        const Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SimulatedMap(),
          ),
        ),
        // Right Panel (Risk & Stats)
        const Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: RiskSummaryPanel(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        Text(
          'Live Risk Map',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: SimulatedMap(),
        ),
        SizedBox(height: 16),
        RiskSummaryPanel(),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String title, bool isSelected) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.black87,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue.withOpacity(0.1),
      onTap: () {},
    );
  }
}
