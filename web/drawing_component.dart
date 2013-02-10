library drawing_component;

import 'dart:html';

import 'canvas_drawer.dart';
import 'canvas_manager.dart';
import 'component.dart';
import 'component_listener.dart';
import 'game_object.dart';
import 'game_event.dart';
import 'drawable.dart';
import 'sprite.dart';
import 'direction.dart';

class DrawingComponent extends Component
  implements ComponentListener
{

  static final DIRECTION_CHANGE_EVENT = 1;
  static final UPDATE_STEP_EVENT = 2;

  CanvasDrawer _drawer;
  CanvasManager _manager;

  bool _scrollBackground = false;

  DrawingComponent(this._manager, this._drawer, this._scrollBackground);

  void update(Drawable obj) {

    if (this._scrollBackground) {
      this._drawer.setOffset(
        obj.x + obj.tileWidth - (this._manager.width ~/ 2),
        obj.y + obj.tileHeight - (this._manager.height ~/ 2)
      );
    }

    Sprite s;
    if (obj.x == obj.oldX && obj.y == obj.oldY) {
      s = obj.getStaticSprite();
    } else {
      s = obj.getMoveSprite();
    }
    this._drawer.drawSprite(s, obj.x, obj.y);


  }

  void listen(GameEvent e) {

    if (null == e) {
      return;
    }
  }

  static GameEvent directionChangeEvent(Direction d) {

    GameEvent e = new GameEvent();
    e.type = DrawingComponent.DIRECTION_CHANGE_EVENT;
    e.data["dir"] = d;
    return e;
  }
}
