import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/colors.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/geocoding/yandex_geocoding.dart';
import 'package:abricoz_app/src/domain/entity/user/location_entity.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/map_address_bloc/map_address_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/polygon_cubit.dart';
import 'package:abricoz_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:abricoz_app/src/presentation/widgets/padding_nav_buttons.dart';
import 'package:abricoz_app/src/presentation/widgets/show_error_snackbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/user/address_entity.dart';
import '../../../../../get_it_sl.dart';
import '../../../../bloc/base_state.dart';
import '../../../../widgets/mixins/yandex_map.dart';

@RoutePage()
class MapAddressScreen extends StatelessWidget {
  const MapAddressScreen({super.key, this.address});
  final AddressEntity? address;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapAddressCubit>(
          create: (_) => MapAddressCubit(sl()),
        ),
        BlocProvider<PolygonCubit>(
          create: (_) => PolygonCubit(sl())..getCityPolygon(),
        ),
      ],
      child: MapAddressView(address: address),
    );
  }
}

class MapAddressView extends StatefulWidget {
  const MapAddressView({super.key, this.address});
  final AddressEntity? address;

  @override
  State<MapAddressView> createState() => _MapAddressViewState();
}

class _MapAddressViewState extends State<MapAddressView> with YandexMapMixin {
  YandexMapController? controller;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 1.5);
  Position? myPosition;
  Uint8List? markerIcon;
  List<Point> polygonPoints = [];
  double markerOffset = 0.0;

  Future<void> setCustomMarker() async {
    markerIcon = await getBytesFromAsset(AppAssets.location, 140);
  }

  Future<void> locatePosition({double zoom = 16}) async {
    try {
      await checkPermission();
      myPosition ??= await Geolocator.getCurrentPosition();

      controller?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: zoom,
            target: Point(
              latitude: myPosition?.latitude ?? 50.300377,
              longitude: myPosition?.longitude ?? 57.154555,
            ),
          ),
        ),
        animation: animation,
      );
      if (myPosition == null) return;
      putMarker(Point(
        latitude: myPosition!.latitude,
        longitude: myPosition!.longitude,
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

  moveToAddress(YandexMapController controller) async {
    if (widget.address?.latitude == null || widget.address?.longitude == null) {
      controller.moveCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            zoom: 13,
            target: Point(
              latitude: 50.300377,
              longitude: 57.154555,
            ),
          ),
        ),
        animation: animation,
      );
    } else {
      double latitude = double.parse(widget.address!.latitude!);
      double longitude = double.parse(widget.address!.longitude!);
      await Future.delayed(const Duration(milliseconds: 200));
      controller.moveCamera(
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
    // final res = await YandexGeo.searchByCoords(point.latitude, point.longitude);
    // if (res != null) {
    //   context.read<MapAddressCubit>().selectAddress(res);
    // }
  }

  setPolygons(List<LocationEntity> polygons) async {
    for (final item in polygons) {
      polygonPoints.add(Point(
        latitude: double.parse(item.latitude),
        longitude: double.parse(item.longitude),
      ));
    }
    // final mapObject = PolygonMapObject(
    //     zIndex: 0,
    //     mapId: MapObjectId(polygons.first.cityId.toString()),
    //     polygon: Polygon(
    //       outerRing: LinearRing(points: polygonPoints),
    //       innerRings: const [],
    //     ),
    //     strokeColor: AppColors.errorRedColor,
    //     strokeWidth: 2.0,
    //     fillColor: AppColors.errorRedColor.withOpacity(0.3),
    //     onTap: (polygon, point) async {
    //       log(point.toString());
    //       putMarker(point);
    //     });
    // context.read<MapAddressCubit>().addMapObject(mapObject);
  }

  @override
  void initState() {
    setCustomMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PolygonCubit, BaseState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          setPolygons(state.entity ?? []);
        }
      },
      child: PopScope(
        onPopInvoked: (can) {
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
                alignment: Alignment.center,
                children: [
                  YandexMap(
                    zoomGesturesEnabled: true,
                    mapObjects: state.mapObjects,
                    onMapTap: (Point point) async {
                      if (isPointInPolygon(point, polygonPoints)) {
                        putMarker(point);
                      } else {
                        showErrorSnackBar(
                            context, S.of(context).notDeliverPlace);
                      }
                    },
                    onMapCreated: (YandexMapController yandexMapController) async {
                      controller = yandexMapController;

                      await Future.delayed(const Duration(milliseconds: 500));
                      moveToAddress(yandexMapController);
                    },
                    onCameraPositionChanged: (CameraPosition position, CameraUpdateReason reason, bool finished) async {
                      // When the camera starts moving, animate the marker upward by 10px
                      if (!finished) {
                        if (markerOffset != -10.0) {
                          setState(() {
                            markerOffset = -10.0;
                          });
                        }
                      }
                      // When movement finishes, animate the marker back to its original position
                      if (finished) {
                        setState(() {
                          markerOffset = 0.0;
                        });
                        final centerPoint = position.target;
                      }
                    },
                  ),
                  IgnorePointer(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.elasticOut,
                      transform: Matrix4.translationValues(0, markerOffset - 14, 0),
                      child: Image.asset(
                        AppAssets.location, // Your marker icon
                        height: 50,
                      ),
                    ),
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
      ),
    );
  }
}
