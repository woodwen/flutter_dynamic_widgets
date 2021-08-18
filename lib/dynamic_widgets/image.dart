import 'package:flutter/material.dart';

import 'basic/handler.dart';
import 'basic/utils.dart';
import 'basic/widget.dart';
import 'config/widget_config.dart';

class ImageHandler extends DynamicBasicWidgetHandler {
  @override
  String get widgetName => 'Image';

  @override
  Widget build(DynamicWidgetConfig? config,
      {Key? key, required BuildContext buildContext}) {
    return _Builder(config, key: key);
  }

  @override
  Map? transformJson(Widget? widget, BuildContext? buildContext) {
    var realImage = widget as Image?;
    if (realImage == null) return null;
    late AssetImage? assetImage;
    late ExactAssetImage? exactAssetImage;
    late NetworkImage? networkImage;


    if (realImage.image is AssetImage) {
      assetImage = realImage.image as AssetImage;
    }
    else if (realImage.image is NetworkImage) {
      networkImage = realImage.image as NetworkImage;
    }
    else if (realImage.image is ResizeImage) {
      var t = realImage.image as ResizeImage;
      if (t.imageProvider is AssetImage) {
        assetImage = t.imageProvider as AssetImage;
      }
      else if (t.imageProvider is ExactAssetImage) {
        exactAssetImage = t.imageProvider as ExactAssetImage;
      }
      else if (t.imageProvider is NetworkImage) {
        networkImage = t.imageProvider as NetworkImage;
      }
    }
    var type = 'network';
    var src = '';
    double? scale = 0.0;
    if (assetImage != null) {
      type = '';
      src = assetImage.assetName;
    } else if (networkImage != null) {
      type = 'network';
      src = networkImage.url;
    }else if(exactAssetImage != null) {
      type = '';
      src = exactAssetImage.assetName;
      scale = exactAssetImage?.scale;
    }

    return {
      'widget': widgetName,
      'xVar': {
        'type': type,
        'src': src,
        'semanticLabel': realImage?.semanticLabel,
        'excludeFromSemantics': realImage.excludeFromSemantics,
        'scale': scale,
        'width': realImage.width,
        'height': realImage.height,
        'color': DynamicWidgetUtils.transformColor(realImage.color),
        'colorBlendMode': DynamicWidgetUtils.transformBlendMode(realImage.colorBlendMode),
        'fit': DynamicWidgetUtils.transformBoxFit(realImage.fit),
        'alignment': DynamicWidgetUtils.transformAlignment(realImage.alignment as Alignment?),
        'repeat': DynamicWidgetUtils.transformImageRepeat(realImage.repeat),
        'centerSlice': DynamicWidgetUtils.transformRect(realImage.centerSlice),
        'matchTextDirection': realImage.matchTextDirection,
        'gaplessPlayback': realImage.gaplessPlayback,
        'filterQuality':DynamicWidgetUtils.transformFilterQuality(realImage.filterQuality)
      },
      'xKey': realImage.key.toString()
    };
  }

  @override
  Type get widgetType => Image;
}

class _Builder extends DynamicBaseWidget {
  final DynamicWidgetConfig? config;

  _Builder(this.config, {Key? key}) : super(config, key: key);

  @override
  _BuilderState createState() => _BuilderState();
}

class _BuilderState extends State<_Builder> {
  ImageConfig? props;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config?.xVar != null) {
      props = ImageConfig.fromJson(widget.config?.xVar ?? {});
    }
    if (props?.type == 'network') {
      return Image.network(
          props?.src ?? '',
          key: widget.config?.xKey != null ? Key(widget.config!.xKey!) : null,
          semanticLabel: props?.semanticLabel,
          excludeFromSemantics: props?.excludeFromSemantics ?? false,
          scale: props?.scale ?? 0,
          width: props?.width,
          height: props?.height,
          color: props?.color,
          colorBlendMode: props?.colorBlendMode,
          fit: props?.fit,
          alignment: props?.alignment ?? Alignment.center,
          repeat: props?.repeat ?? ImageRepeat.noRepeat,
          centerSlice: props?.centerSlice,
          matchTextDirection: props?.matchTextDirection ?? false,
          gaplessPlayback: props?.gaplessPlayback ?? false,
          filterQuality: props?.filterQuality ?? FilterQuality.low
      );
    }
    else {
      return Image.asset(
          props?.src ?? '',
          key: widget.config?.xKey != null ? Key(widget.config!.xKey!) : null,
          semanticLabel: props?.semanticLabel,
          excludeFromSemantics: props?.excludeFromSemantics ?? false,
          scale: props?.scale,
          width: props?.width,
          height: props?.height,
          color: props?.color,
          colorBlendMode: props?.colorBlendMode,
          fit: props?.fit,
          alignment: props?.alignment ?? Alignment.center,
          repeat: props?.repeat ?? ImageRepeat.noRepeat,
          centerSlice: props?.centerSlice,
          matchTextDirection: props?.matchTextDirection ?? false,
          gaplessPlayback: props?.gaplessPlayback ?? false,
          filterQuality: props?.filterQuality ?? FilterQuality.low
      );
    }
  }
}

/// The props of Text config
class ImageConfig {
  late String? type; //网络图片或者本地图片
  late String? src;
  late String? semanticLabel;
  late bool? excludeFromSemantics;
  late double? scale;
  late double? width;
  late double? height;
  late Color? color;
  late BlendMode? colorBlendMode;
  late BoxFit? fit;
  late Alignment? alignment;
  late ImageRepeat? repeat;
  late Rect? centerSlice;
  late bool? matchTextDirection;
  late bool? gaplessPlayback;
  late FilterQuality? filterQuality;

  ImageConfig({
    this.type,
    this.src,
    this.semanticLabel,
    this.excludeFromSemantics,
    this.scale,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment,
    this.repeat,
    this.centerSlice,
    this.matchTextDirection,
    this.gaplessPlayback,
    this.filterQuality,
  });

  ImageConfig.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'];
    src = json['src'];
    semanticLabel = json['semanticLabel'];
    excludeFromSemantics = json['excludeFromSemantics'];
    scale = json['scale']?.toDouble();
    width = json['width']?.toDouble() ;
    height = json['height']?.toDouble();
    color =  DynamicWidgetUtils.colorAdapter(json['color']);
    colorBlendMode = DynamicWidgetUtils.blendModeAdapter(json['blendMode']) ;
    fit = DynamicWidgetUtils.boxFitAdapter(json['fit']);
    alignment = (DynamicWidgetUtils.alignmentAdapter(json['alignment'])??Alignment.center) ;
    repeat = DynamicWidgetUtils.imageRepeatAdapter(json['repeat']);
    centerSlice = DynamicWidgetUtils.rectAdapter(json['centerSlice']);
    matchTextDirection = json['matchTextDirection'];
    gaplessPlayback = json['gaplessPlayback'];
    filterQuality = DynamicWidgetUtils.filterQualityAdapter(json['filterQuality']);
  }
}
