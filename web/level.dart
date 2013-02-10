library level;

import 'dart:html';

import 'sprite.dart';
import 'sprite_sheet.dart';
import 'canvas_drawer.dart';
import 'canvas_manager.dart';
import 'game_object.dart';
import 'game_event.dart';
import 'player.dart';
import 'direction.dart';
import 'bullet.dart';
import 'bullet_input_component.dart';
import 'drawing_component.dart';
import 'component_listener.dart';

class CreateBulletEvent extends GameEvent {

  CreateBulletEvent(Direction d, int x, int y) : super() {
    this.type = Level.CREATE_BULLET_EVENT;
    this.data["direction"] = d;
    this.data["x"] = x;
    this.data["y"] = y;
  }
}

class Level extends GameObject implements ComponentListener {

  static final int CREATE_BULLET_EVENT = 1;

  int _rows;
  int _cols;

  int _tileWidth;
  int _tileHeight;

  int _layer = -1;

  CanvasManager _manager;
  CanvasDrawer _drawer;

  List<List<Sprite>> _sprites;

  List<GameObject> _objects;
  Player _player;

  Level(this._drawer, this._manager,
      this._rows, this._cols, this._tileWidth, this._tileHeight) :
        super(DIR_DOWN, 0, 0)
  {
    this._sprites = new List<List<Sprite>>();
    this._objects = new List<GameObject>();
  }

  int get tileWidth => this._tileWidth;
  int get tileHeight => this._tileHeight;
  int get rows => this._rows;
  int get cols => this._cols;

  int _posToIdx(int row, int col) {
    return this._cols * row + col;
  }

  void newLayer() {
    this._sprites.add(new List<Sprite>(this._rows * this._cols));
    this._layer++;
  }

  void setSpriteAt(Sprite s, int row, int col) {

    int pos = this._posToIdx(row, col);
    if (this._layer == -1 ||
        pos < 0 ||
        pos >= this._sprites[this._layer].length)
    {
      return;
    }

    this._sprites[this._layer][pos] = s;
  }
  Sprite getSpriteAt(int row, int col) {

    int pos = this._posToIdx(row, col);
    if (this._layer == -1 ||
        pos < 0 ||
        pos >= this._sprites[this._layer].length)
    {
      return null;
    }

    return this._sprites[this._layer][pos];
  }

  void addPlayerObject(Player p) {
    this._player = p;
  }

  void addObject(GameObject obj) {
    this._objects.add(obj);
  }

  void listen(GameEvent e) {
    if (e.type == Level.CREATE_BULLET_EVENT) {
      Direction d = e.data["direction"];
      int x = e.data["x"];
      int y = e.data["y"];

      Bullet b = new Bullet(d, x, y,
          new BulletInputComponent(),
          new DrawingComponent(this._manager, this._drawer, false));
      this.addObject(b);
    }
  }

  void update() {
    this.draw(this._drawer);
    this._player.update();
    for (GameObject o in this._objects) {
      o.update();
    }
  }

  void draw(CanvasDrawer d) {

    for (List<Sprite> layer in this._sprites) {

      int row = 0;
      int col = 0;
      for (Sprite s in layer) {
        if (s != null) {
          d.drawSprite(s, col * this._tileWidth, row * this._tileHeight);
        }
        col++;
        if (col >= this._cols) {
          row++;
          col = 0;
        }
      }
    }
  }

  static Map<String, Sprite> parseSpriteSheet(
      SpriteSheet sheet, Map<String, List<int>> data)
  {

    Map<String, Sprite> sprites = new Map<String, Sprite>();

    for (String sName in data.keys) {
      int x = data[sName][0];
      int y = data[sName][1];
      sprites[sName] = sheet.spriteAt(x, y);
    }

    return sprites;
  }
}
