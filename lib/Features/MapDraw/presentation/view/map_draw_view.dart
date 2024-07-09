


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Home/presentation/Manager/home_controller.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapDrawView extends StatelessWidget {
  const MapDrawView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(HomeController());

    List<LatLng>pologonPoints=[
      const LatLng(37.42202295228997, -122.08403103053568),
      const LatLng(37.42202295228988, -122.08403103053532),
      const LatLng(37.42202295228918, -122.08403103053512),
      const LatLng(37.42202295228944, -122.08403103053526),
    ];

    return Scaffold(
      appBar: CustomAppBar('MAP', true, 55),
      body: ListView(
        children:  [
          //const SizedBox(height: 31,),
          GetBuilder<HomeController>(
              builder: (con) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    onCameraMove: controller.onCameraMove,
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLatLng,
                      //  zoom: controller.zoom,
                    ),
                    polygons: {
                      Polygon(
                        polygonId: const PolygonId('1'),
                        points: pologonPoints
                      )
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId('1'),
                        position: controller.currentLatLng,
                        icon: BitmapDescriptor.defaultMarker
                      ),

                    },
                    onMapCreated: controller.onMapCreated,
                    mapType: MapType.normal,
                  ),
                );
              }
          ),

        ],
      ),
    );
  }
}
