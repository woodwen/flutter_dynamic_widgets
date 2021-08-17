import 'package:flutter/cupertino.dart';

import 'basic/handler.dart';
import 'basic/utils.dart';
import 'basic/widget.dart';
import 'config/widget_config.dart';

/// Row handler
class RowHandler extends DynamicBasicWidgetHandler {

  @override
  String get widgetName => 'Row';

  @override
  Widget build(DynamicWidgetConfig? config,
      {Key? key, required BuildContext buildContext, Function(String value)? event}) {
    return _Builder(config, event, key: key);
  }

  @override
  Map? transformJson(Widget? widget, BuildContext? buildContext) {
    var row = widget as Row?;
    if (row == null) return null;
    return {
      'widget': widgetName,
      'children': DynamicWidgetBuilder.transformList(row.children, buildContext),
      'xVar': {
        'mainAxisAlignment': DynamicWidgetUtils.transformMainAxisAlignment(row.mainAxisAlignment),
        'mainAxisSize': DynamicWidgetUtils.transformMainAxisSize(row.mainAxisSize),
        'crossAxisAlignment': DynamicWidgetUtils.transformCrossAxisAlignment(row.crossAxisAlignment),
        'textDirection': DynamicWidgetUtils.transformTextDirection(row.textDirection),
        'verticalDirection': DynamicWidgetUtils.transformVerticalDirection(row.verticalDirection),
        'textBaseline': DynamicWidgetUtils.transformTextBaseline(row.textBaseline),
      },
      'xKey': row.key.toString()
    };
  }

  @override
  Type get widgetType => Row;
}

class _Builder extends DynamicBaseWidget {
  final DynamicWidgetConfig? config;
  final Function(String value)? event;

  _Builder(this.config, this.event, {Key? key}) : super(config, event, key: key);

  @override
  _BuilderState createState() => _BuilderState();
}

class _BuilderState extends State<_Builder> {
  RowConfig? props;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config?.xVar != null) {
      props = RowConfig.fromJson(widget.config?.xVar ?? {});
    }
    List<Widget> _children = [];
    if (widget.config?.children != null) {
      widget.config?.children?.forEach((e) {
        Widget? _child = DynamicWidgetBuilder.buildWidget(e, context: context, event: widget.event);
        if (_child != null) {
          _children.add(_child);
        }
      });
    }

    return Row(
      key: widget.config?.xKey != null ? Key(widget.config!.xKey!) : null,
      mainAxisAlignment: props?.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: props?.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment: props?.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: props?.textDirection,
      verticalDirection: props?.verticalDirection ?? VerticalDirection.down,
      textBaseline: props?.textBaseline,
      children: _children,
    );
  }

}

/// The props of Row config
class RowConfig {
  late MainAxisAlignment? mainAxisAlignment;
  late MainAxisSize? mainAxisSize;
  late CrossAxisAlignment? crossAxisAlignment;
  late TextDirection? textDirection;
  late VerticalDirection? verticalDirection;
  late TextBaseline? textBaseline;

  RowConfig(
      {this.mainAxisAlignment,
      this.mainAxisSize,
      this.crossAxisAlignment,
      this.textDirection,
      this.verticalDirection,
        this.textBaseline});

  RowConfig.fromJson(Map<dynamic, dynamic> json) {
    mainAxisAlignment = DynamicWidgetUtils.mainAxisAlignmentAdapter(json['mainAxisAlignment']);
    mainAxisSize = DynamicWidgetUtils.mainAxisSizeAdapter(json['mainAxisSize']);
    crossAxisAlignment = DynamicWidgetUtils.crossAxisAlignmentAdapter(json['crossAxisAlignment']);
    textDirection = DynamicWidgetUtils.textDirectionAdapter(json['textDirection']);
    verticalDirection = DynamicWidgetUtils.verticalDirectionAdapter(json['verticalDirection']);
    textBaseline = DynamicWidgetUtils.textBaselineAdapter(json['textBaseline']);
  }

}