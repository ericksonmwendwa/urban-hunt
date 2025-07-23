import 'dart:async';
import 'dart:math';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:urban_hunt/models/property_model.dart';
import 'package:urban_hunt/services/property_service.dart';
import 'package:urban_hunt/utils/marker.dart';
import 'package:urban_hunt/widget/loading_icon.dart';
import 'package:urban_hunt/widget/map_marker.dart';
import 'package:urban_hunt/widget/map_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final PropertyService _propertyService = PropertyService();

  final NumberFormat _formattter = NumberFormat('KES ,###', 'en_US');

  bool _loadingMapData = true;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CustomInfoWindowController _popupController =
      CustomInfoWindowController();

  static const double _defaultLat = -1.286389;
  static const double _defaultLng = 36.817223;
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(_defaultLat, _defaultLng),
    zoom: 8.0,
  );

  // Maximum amount of cluster managers.
  static const int _clusterManagerMaxCount = 1;

  // Map of clusterManagers with identifier as the key.
  Map<ClusterManagerId, ClusterManager> clusterManagers =
      <ClusterManagerId, ClusterManager>{};

  // Map of markers with identifier as the key.
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // Counter for added cluster manager ids.
  int _clusterManagerIdCounter = 1;

  Future<void> _addClusterManager() async {
    if (clusterManagers.length == _clusterManagerMaxCount) {
      return;
    }

    final String clusterManagerIdVal =
        'cluster_manager_id_$_clusterManagerIdCounter';

    _clusterManagerIdCounter++;

    final ClusterManagerId clusterManagerId = ClusterManagerId(
      clusterManagerIdVal,
    );

    final ClusterManager clusterManager = ClusterManager(
      clusterManagerId: clusterManagerId,
    );

    setState(() {
      clusterManagers[clusterManagerId] = clusterManager;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _addMarkersToCluster(clusterManager);
    });
  }

  Future<void> _addMarkersToCluster(ClusterManager clusterManager) async {
    final List<PropertyModel> properties = await _getProperties();

    if (properties.isEmpty) return;

    for (final PropertyModel property in properties) {
      final MarkerId markerId = MarkerId(property.id);

      final double offset = Random().nextDouble() * 0.001;

      String price = _formattter.format(property.price);

      LatLng position = LatLng(
        property.location.coordinates.lat + offset,
        property.location.coordinates.lng + offset,
      );

      final Marker marker = Marker(
        clusterManagerId: clusterManager.clusterManagerId,
        markerId: markerId,
        position: position,
        icon: await getCustomIcon(price),
        onTap: () {
          _popupController.addInfoWindow?.call(
            MapWidget(property: property),
            position,
          );
        },
      );

      markers[markerId] = marker;
    }

    _loadingMapData = false;

    setState(() {});
  }

  Future<List<PropertyModel>> _getProperties() async {
    List<PropertyModel> properties = await _propertyService.fetchProperties();

    return properties;
  }

  Future<BitmapDescriptor> getCustomIcon(String price) async {
    return MapMarker(price: price).toBitmapDescriptor();
  }

  @override
  void initState() {
    super.initState();

    _addClusterManager();
  }

  @override
  void dispose() {
    super.dispose();

    _popupController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingMapData) {
      return const Center(child: LoadingIcon());
    }

    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);

            _popupController.googleMapController = controller;
          },
          onTap: (LatLng position) {
            _popupController.hideInfoWindow?.call();
          },
          onCameraMove: (CameraPosition position) {
            _popupController.onCameraMove?.call();
          },
          markers: Set<Marker>.of(markers.values),
          clusterManagers: Set<ClusterManager>.of(clusterManagers.values),
        ),
        CustomInfoWindow(
          controller: _popupController,
          width: 320.0,
          height: 100.0,
        ),
      ],
    );
  }
}
