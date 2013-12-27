part of ui;

class WindowView extends View {

  WindowView(UIInterface ui, DivElement rootElement) : super(ui) {

    this._root = rootElement;
    window.console.log("creating new WindowView: ${this._root.id}");
    this._root.classes.add("root");
    this._root.classes.add("ui2");
  }
}

