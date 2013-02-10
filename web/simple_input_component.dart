library simple_input_component;

import 'dart:html';

import 'component.dart';
import 'component_listener.dart';
import 'drawing_component.dart';
import 'keyboard_listener.dart';
import 'game_event.dart';
import 'game_object.dart';
import 'direction.dart';
import 'player.dart';

class SimpleInputComponent extends Component
  implements KeyboardListener {

  Map<int, bool> _pressed;
  DrawingComponent _drawer;

  bool _spawnBullet = false;

  SimpleInputComponent(this._drawer) {
    this._pressed = new Map<int, bool>();
  }

  void update(Player obj) {

    if (this._pressed[KeyboardListener.KEY_UP] == true) {
      obj.moveUp();
    } else if (this._pressed[KeyboardListener.KEY_DOWN] == true) {
      obj.moveDown();
    }
    if (this._pressed[KeyboardListener.KEY_LEFT] == true) {
      obj.moveLeft();
    } else if (this._pressed[KeyboardListener.KEY_RIGHT] == true) {
      obj.moveRight();
    }

    if (this._spawnBullet) {
      obj.spawnBullet();
      this._spawnBullet = false;
    }
  }

  void onKeyDown(KeyboardEvent e) {
    this._pressed[e.keyCode] = true;
  }
  void onKeyUp(KeyboardEvent e) {
    this._pressed[e.keyCode] = false;
  }
  void onKeyPressed(KeyboardEvent e) {
    if (e.keyCode == KeyboardListener.KEY_SPACE) {
      this._spawnBullet = true;
    }
  }
}

