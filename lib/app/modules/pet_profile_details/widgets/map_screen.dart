import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final LatLng _center = const LatLng(54.6872, 25.2797);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: _center, zoom: 12.0),
            markers: {
              Marker(
                markerId: MarkerId('vilniusMarker'),
                position: _center,
                infoWindow: InfoWindow(title: 'Location'),
              ),
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('44A Skydo Street, Vilnius, Lithuania', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
