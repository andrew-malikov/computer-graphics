import 'package:GraphicsApp/vector_mode/arch/i_observer.dart';
import 'package:GraphicsApp/vector_mode/models/polygon_model.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/renders/grid_render.dart';
import 'package:GraphicsApp/vector_mode/renders/polygon_render.dart';
import 'package:GraphicsApp/view/bitmap.dart';
import 'package:GraphicsApp/view/layer.dart';

class PolygonStorageModel implements IObserver {
  PolygonsModel _polygons;
  PolygonModel _polygon;
  Layer _layer;
  PolygonRender _render;
  GridRender _grid;

  PolygonStorageModel(
      this._layer, this._render, this._grid, this._polygons, this._polygon) {
    _polygon.subscribeObserver(this);
    _polygons.subscribeObserver(this);

    Update();
  }

  void _renderBody(Bitmap bitmap) {
    bitmap.clearAll();

    _grid.render(bitmap);
    for (var polygon in _polygons.values) {
      _render.render(bitmap, polygon);
    }
  }

  void _renderPreview(Bitmap bitmap) {
    bitmap.clearAll();
    if (_polygon.value == null) return;
    _render.render(bitmap, _polygon.value);
  }

  @override
  void Update() {
    _renderBody(_layer.body);
    _renderPreview(_layer.preview);
  }
}
