import 'dart:developer';

import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/colors.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/geocoding/yandex_geocoding.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/map_address_bloc/map_address_cubit.dart';
import 'package:abricoz_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:abricoz_app/src/presentation/widgets/padding_nav_buttons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/user/address_entity.dart';
import '../../../../widgets/mixins/yandex_map.dart';

@RoutePage()
class MapAddressScreen extends StatefulWidget {
  const MapAddressScreen({super.key, this.address});
  final AddressEntity? address;

  @override
  State<MapAddressScreen> createState() => _MapAddressScreenState();
}

class _MapAddressScreenState extends State<MapAddressScreen>
    with YandexMapMixin {
  YandexMapController? controller;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 1.5);
  Position? myPosition;
  Position? selectPosition;
  Uint8List? markerIcon;
  final List<MapObject> mapObjects = [];

  Future<void> setCustomMarker() async {
    markerIcon = await getBytesFromAsset(AppAssets.location, 140);
  }

  Future<void> locatePosition({double zoom = 16}) async {
    try {
      await checkPermission();
      myPosition ??= await Geolocator.getCurrentPosition();

      selectPosition = myPosition;
      controller?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: zoom,
            target: Point(
              latitude: selectPosition?.latitude ?? 50.300377,
              longitude: selectPosition?.longitude ?? 57.154555,
            ),
          ),
        ),
        animation: animation,
      );
      if (selectPosition == null) return;
      putMarker(Point(
        latitude: selectPosition!.latitude,
        longitude: selectPosition!.longitude,
      ));
    } catch (e) {
      controller?.moveCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            zoom: 14,
            target: Point(
              latitude: 50.300377, //position.latitude,
              longitude: 57.154555, // position.longitude,
            ),
          ),
        ),
        animation: animation,
      );
    }
  }

  moveToAddress() {
    if (widget.address?.latitude == null || widget.address?.longitude == null) {
      locatePosition();
    } else {
      double latitude = double.parse(widget.address!.latitude!);
      double longitude = double.parse(widget.address!.longitude!);
      controller?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 18,
            target: Point(
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        ),
        animation: animation,
      );
      putMarker(Point(
        latitude: latitude,
        longitude: longitude,
      ));
    }
  }

  Future<void> putMarker(Point point) async {
    log(point.toString(), name: 'Point');

    PlacemarkMapObject? placeMark = PlacemarkMapObject(
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromBytes(markerIcon!),
          anchor: const Offset(0.5, 1),
        ),
      ),
      mapId: const MapObjectId('normal_icon_placemark'),
      point: Point(
        latitude: point.latitude,
        longitude: point.longitude,
      ),
      opacity: 1,
      isDraggable: true,
      zIndex: 1,
    );
    context.read<MapAddressCubit>().addMapObject(placeMark);
    final res = await YandexGeo.searchByCoords(point.latitude, point.longitude);
    if (res != null) {
      context.read<MapAddressCubit>().selectAddress(res);
    }
  }

  @override
  void initState() {
    setCustomMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (can){
        context.read<MapAddressCubit>().setInitState();
      },
      child: BlocBuilder<MapAddressCubit, MapAddressState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: state.selectAddress?.street != null
                ? PaddingForNavButtons(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            '${state.selectAddress?.street}',
                            style: AppTextStyle.bodyLarge,
                          ),
                        ),
                        CustomMainButton(
                          text: S.of(context).select,
                          onTap: () {
                            context.router.push(AddOrChangeAddressRoute(
                              address: widget.address,
                              selectAddress: state.selectAddress!,
                            ));
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            body: Stack(
              children: [
                YandexMap(
                  zoomGesturesEnabled: true,
                  mapObjects: state.mapObjects,
                  onMapTap: (Point point) async {
                    putMarker(point);
                  },
                  onMapCreated: (YandexMapController yandexMapController) async {
                    controller = yandexMapController;
                    moveToAddress();
                  },
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  top: kToolbarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => context.router.maybePop(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 56,
                          width: 56,
                          decoration: const BoxDecoration(
                              color: AppColors.white, shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            AppAssets.back,
                            height: 26,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => locatePosition(zoom: 18),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          height: 56,
                          width: 56,
                          decoration: const BoxDecoration(
                              color: AppColors.white, shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            AppAssets.myLocation,
                            height: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
