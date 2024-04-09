// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';
import 'package:ck_woocommerce_api/models/productDetailDataModel.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

class GalleryWidget extends StatefulWidget {
  final int? currentImageIndex;
  final List<Images>? pics;

  // final List pics;

  const GalleryWidget({this.currentImageIndex, required this.pics, Key? key})
      : super(key: key);

  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget>
    with SingleTickerProviderStateMixin {
  var rebuildIndex = StreamController<int>.broadcast();
  var rebuildSwiper = StreamController<bool>.broadcast();
  AnimationController? _animationController;
  Animation<double>? _animation;
  late Function animationListener;

  List<double> doubleTapScales = <double>[1.0001, 2.0];

  var widthOfItem = size.width(200);

  int? currentIndex;
  bool _showSwiper = true;

  late ExtendedPageController _pageController;
  late ScrollController _horizontalListScrollController;

  @override
  void initState() {
    currentIndex = widget.currentImageIndex;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    _pageController = ExtendedPageController(initialPage: currentIndex!);
    _horizontalListScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    rebuildIndex.close();
    rebuildSwiper.close();
    _animationController?.dispose();
    _pageController.dispose();
    _horizontalListScrollController.dispose();
    clearGestureDetailsCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shadowColor: Colors.transparent,
      child: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return ExtendedImageSlidePage(
            slideAxis: SlideAxis.both,
            slideType: SlideType.onlyImage,
            onSlidingPage: (state) {
              var showSwiper = !state.isSliding;
              if (showSwiper != _showSwiper) {
                _showSwiper = showSwiper;
                rebuildSwiper.add(_showSwiper);
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ExtendedImageGesturePageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.pics?.length,
                  onPageChanged: (int index) {
                    currentIndex = index;
                    rebuildIndex.add(index);
                    _horizontalListScrollController.animateTo(
                        currentIndex! * widthOfItem.toDouble(),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate);
                    setState(() {});
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var item = widget.pics?[index].src;
                    Widget image = Hero(
                        tag: widget.pics?[index].src ?? "",
                        child: ExtendedImage.network(
                          item!,
                          fit: BoxFit.contain,
                          enableSlideOutPage: false,
                          mode: ExtendedImageMode.gesture,
                          initGestureConfigHandler: (state) {
                            double? initialScale = 1.0001;
                            if (state.extendedImageInfo != null) {
                              initialScale = _initialScale(
                                  size: Size(constraints.maxWidth,
                                      constraints.maxHeight),
                                  initialScale: initialScale,
                                  imageSize: Size(
                                      state.extendedImageInfo!.image.width
                                          .toDouble(),
                                      state.extendedImageInfo!.image.height
                                          .toDouble()));
                            }
                            return GestureConfig(
                              inPageView: true,
                              initialScale: initialScale!,
                              maxScale: max(initialScale, 5.0),
                              animationMaxScale: max(initialScale, 5.0),
                              cacheGesture: false,
                            );
                          },
                          onDoubleTap: (ExtendedImageGestureState state) {
                            var pointerDownPosition = state.pointerDownPosition;
                            var begin = state.gestureDetails!.totalScale;
                            double end;
                            _animation?.removeListener(
                                animationListener as void Function());
                            _animationController!.stop();
                            _animationController!.reset();
                            if (begin == doubleTapScales[0]) {
                              end = doubleTapScales[1];
                            } else {
                              end = doubleTapScales[0];
                            }
                            animationListener = () => state.handleDoubleTap(
                                scale: _animation!.value,
                                doubleTapPosition: pointerDownPosition);
                            _animation = _animationController!
                                .drive(Tween<double>(begin: begin, end: end));
                            _animation!.addListener(
                                animationListener as void Function());
                            _animationController!.forward();
                          },
                        ));
                    return image;
                  },
                ),
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  start: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${currentIndex! + 1}/${widget.pics?.length}',
                          style: TextStyle(fontSize: 16)),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.clear, color: iconColor)),
                    ],
                  ),
                ),
                PositionedDirectional(
                  end: 0,
                  start: 0,
                  bottom: 5,
                  child: SizedBox(
                    height: size.height(150),
                    child: ScrollConfiguration(
                      behavior: const MaterialScrollBehavior()
                          .copyWith(overscroll: false),
                      child: ListView.separated(
                        itemCount: widget.pics?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        controller: _horizontalListScrollController,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: 10),
                        itemBuilder: (context, index) => UnconstrainedBox(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                                _pageController.jumpToPage(currentIndex!);
                              });
                            },
                            child: Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: AssetImage(widget.pics[index]),
                                  //     fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  border: currentIndex == index
                                      ? Border.all(
                                          color: primaryBlackColor, width: 3.5)
                                      : Border.all(
                                          color: shadowColor, width: 1),
                                ),
                                child: CustomNetworkImage(
                                  image: widget.pics?[index].src ?? "",
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  double? _initialScale(
      {required Size imageSize, required Size size, double? initialScale}) {
    var n1 = imageSize.height / imageSize.width;
    var n2 = size.height / size.width;
    if (n1 > n2) {
      final fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      var destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      var destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }
    return initialScale;
  }
}
