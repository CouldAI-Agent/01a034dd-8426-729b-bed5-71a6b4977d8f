import 'package:flutter/material.dart';

class SimulatedMap extends StatelessWidget {
  const SimulatedMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.shade200),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=1000'), // Topographic placeholder
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Stack(
        children: [
          // Map controls
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              children: [
                FloatingActionButton.small(onPressed: (){}, child: const Icon(Icons.add), heroTag: 'zoomIn'),
                const SizedBox(height: 8),
                FloatingActionButton.small(onPressed: (){}, child: const Icon(Icons.remove), heroTag: 'zoomOut'),
              ],
            ),
          ),
          
          // Simulated Risk Zones
          _buildZone(top: 50, left: 100, color: Colors.orange, label: 'Cherrapunji\nRisk: 0.75'),
          _buildZone(top: 150, left: 200, color: Colors.red, label: 'NH-40\nBlocked', isPulsing: true),
          _buildZone(top: 250, left: 80, color: Colors.green, label: 'Shillong\nNormal'),
          _buildZone(top: 80, left: 350, color: Colors.yellow, label: 'Village A\nWatch'),
          
          // Map Legend
          Positioned(
            left: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Risk Levels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 4),
                  _buildLegendItem(Colors.green, 'Low (0.0 - 0.3)'),
                  _buildLegendItem(Colors.yellow, 'Watch (0.3 - 0.55)'),
                  _buildLegendItem(Colors.orange, 'High (0.56 - 0.75)'),
                  _buildLegendItem(Colors.red, 'Imminent (> 0.75)'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildZone({required double top, required double left, required Color color, required String label, bool isPulsing = false}) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          Container(
            width: isPulsing ? 24 : 16,
            height: isPulsing ? 24 : 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.5), blurRadius: isPulsing ? 12 : 4, spreadRadius: isPulsing ? 4 : 0)
              ]
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
