import 'package:flutter/material.dart';
import '../widgets/simulated_map.dart';
import '../widgets/risk_summary.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    // Theme colors matching the image
    const primaryColor = Color(0xFF0F203C); // Dark blue for app bar and sidebar
    const bgColor = Color(0xFFF3F4F6); // Light grey background
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.terrain, color: primaryColor, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'NER-SAFE Landslide Risk Monitoring',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.dark_mode_outlined), onPressed: () {}),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 16,
            child: Icon(Icons.person, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              backgroundColor: primaryColor,
              unselectedIconTheme: const IconThemeData(color: Colors.white54),
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white54, fontSize: 12),
              selectedLabelTextStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                NavigationRailDestination(icon: Icon(Icons.map), label: Text('Live Map')),
                NavigationRailDestination(icon: Icon(Icons.warning_amber), label: Text('Alerts')),
                NavigationRailDestination(icon: Icon(Icons.bar_chart), label: Text('Reports')),
                NavigationRailDestination(icon: Icon(Icons.assignment), label: Text('Field Reports')),
                NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
              ],
            ),
          Expanded(
            child: isDesktop ? _buildDesktopContent() : _buildMobileContent(),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
    );
  }

  Widget _buildDesktopContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Stats Row
          Row(
            children: [
              Expanded(child: _buildStatCard('24', 'High Risk Zones', Icons.warning, Colors.red)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('8', 'Active Alerts', Icons.flash_on, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('12', 'Roads Blocked', Icons.directions_car, Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('96%', 'Sensors Online', Icons.wifi, Colors.green)),
            ],
          ),
          const SizedBox(height: 16),
          // Middle Row: Map and Alerts
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const SimulatedMap(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Container(
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Active Alerts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildAlertItem('Landslide warning issued in Mawsynram area', 'East Khasi Hills', '10 mins ago', 'CRITICAL', Colors.red),
                            _buildAlertItem('Heavy rainfall alert for next 24 hours', 'Cherrapunji', '1 hour ago', 'HIGH', Colors.orange),
                            _buildAlertItem('Soil moisture critically high', 'NH-6 Segment B', '2 hours ago', 'HIGH', Colors.orange),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bottom Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 250,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  child: const Center(child: Text('Rainfall Linked Risk Forecast Chart Placeholder')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 250,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  child: const Center(child: Text('Road Connectivity Status Chart Placeholder')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 250,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recent Field Reports', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Slope crack observed near Sonapur tunnel.', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('NH-6, Meghalaya • UNDER VERIFICATION', style: TextStyle(fontSize: 12, color: Colors.orange)),
                      const Spacer(),
                      ElevatedButton(onPressed: () {}, child: const Text('View / Edit Report')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Responsive Stats Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard('24', 'High Risk', Icons.warning, Colors.red),
            _buildStatCard('8', 'Alerts', Icons.flash_on, Colors.orange),
            _buildStatCard('12', 'Roads', Icons.directions_car, Colors.green),
            _buildStatCard('96%', 'Sensors', Icons.wifi, Colors.green),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const SimulatedMap(),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Active Alerts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildAlertItem('Landslide warning issued in Mawsynram area', 'East Khasi Hills', '10 mins ago', 'CRITICAL', Colors.red),
              _buildAlertItem('Heavy rainfall alert for next 24 hours', 'Cherrapunji', '1 hour ago', 'HIGH', Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String location, String time, String tag, Color tagColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning, color: tagColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(location, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              const Spacer(),
              Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(tag, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: tagColor)),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 20),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('View Details', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
