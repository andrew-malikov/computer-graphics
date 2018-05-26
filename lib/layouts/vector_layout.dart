import 'dart:html';

import 'package:GraphicsApp/components/card.dart';
import 'package:GraphicsApp/components/colorPicker.dart';
import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/models/polygon_model.dart';
import 'package:GraphicsApp/vector_mode/models/polygon_storage_model.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/renders/polygon_render.dart';
import 'package:GraphicsApp/vector_mode/renders/render_metadata.dart';
import 'package:GraphicsApp/vector_mode/widgets/clipped_polygon_build_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/box_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/identity_transform_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/models/clipped_polygon_build_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/models/polygon_build_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/polygon_build_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/projection_transform_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/reflect_x_transform_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/reflect_y_transform_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/rotate_transform_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/scale_transform_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/shift_transform_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/tools_widget.dart';
import 'package:GraphicsApp/vector_mode/widgets/translate_transform_widget.dart';
import 'package:GraphicsApp/view/layer.dart';

class VectorLayout {
  Layer layer;
  ColorPicker colorPicker;
  CardComponent colorPickerCard;
  VectorLayoutModel model;
  VectorLayoutWidgets widgets;

  VectorLayout(num width, num height) {
    layer = new Layer(width, height);
    colorPicker = new ColorPicker();
    colorPickerCard = new CardComponent("ColorPicker", colorPicker.render);

    model = new VectorLayoutModel(layer, colorPicker.color, 1);
    widgets = new VectorLayoutWidgets(model.polygon, model.polygons, layer);
  }

  void setUpLayout() {
    document.querySelector('#mainFrame').append(widgets.toolsContainer.node);
    document.querySelector('#mainFrame').append(layer.render);
    document.querySelector('#mainFrame').append(colorPickerCard.render);
  }
}

class VectorLayoutModel {
  RenderMetadata metadata;
  PolygonRender render;

  PolygonModel polygon;
  PolygonsModel polygons;
  PolygonStorageModel storage;

  VectorLayoutModel(Layer layer, Color color, num width) {
    metadata = new RenderMetadata(color, width);
    render = new PolygonRender(metadata);
    polygon = new PolygonModel();
    polygons = new PolygonsModel();
    storage = new PolygonStorageModel(layer, render, polygons, polygon);
  }
}

class VectorLayoutWidgets {
  PolygonBuildModel polygonBuildModel;
  PolygonBuildWidget polygonBuild;

  ClippedPolygonBuildModel clippedPolygonBuildModel;
  ClippedPolygonBuildWidget clippedPolygonBuild;

  IdentityTransformWidget identityWidget;
  ScaleTransformWidget scaleWidget;
  RotateTransformWidget rotateWidget;
  ReflectXTransformWidget reflectXWidget;
  ReflectYTransformWidget reflectYWidget;
  ShiftTransformWidget shiftWidget;
  TranslateTransformWidget translateWidget;
  ProjectionTransformWidget projectionWidget;

  ToolsWidget tools;
  BoxContainer toolsContainer;

  VectorLayoutWidgets(
      PolygonModel polygon, PolygonsModel polygons, Layer layer) {
    polygonBuildModel = new PolygonBuildModel(polygon, polygons, layer.preview);
    polygonBuild = new PolygonBuildWidget(polygonBuildModel);

    clippedPolygonBuildModel =
        new ClippedPolygonBuildModel(polygons, layer.preview);
    clippedPolygonBuild =
        new ClippedPolygonBuildWidget(clippedPolygonBuildModel);

    identityWidget = new IdentityTransformWidget(polygons);
    scaleWidget = new ScaleTransformWidget(polygons);
    rotateWidget = new RotateTransformWidget(polygons);
    reflectXWidget = new ReflectXTransformWidget(polygons);
    reflectYWidget = new ReflectYTransformWidget(polygons);
    shiftWidget = new ShiftTransformWidget(polygons);
    translateWidget = new TranslateTransformWidget(polygons);
    projectionWidget = new ProjectionTransformWidget(polygons);

    tools = new ToolsWidget();
    toolsContainer = new BoxContainer();

    tools.addTool(polygonBuild, Icons['line']);
    tools.addTool(clippedPolygonBuild, Icons['segment']);

    tools.addTool(scaleWidget, Icons['scale']);
    tools.addTool(rotateWidget, Icons['rotate']);
    tools.addTool(reflectXWidget, Icons['reflect_x']);
    tools.addTool(reflectYWidget, Icons['reflect_y']);
    tools.addTool(translateWidget, Icons['move']);
    tools.addTool(projectionWidget, Icons['projection']);

    toolsContainer.content = tools.node;
  }
}
