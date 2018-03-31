import 'dart:html';

class CardComponent {
  HtmlElement _root;
  CardHeader _header;
  CardContent _content;

  CardComponent(String title, HtmlElement content) {
    _setUpContent(title, content);
  }

  void _setUpContent(String title, HtmlElement content) {
    _root = new DivElement();
    _header = new CardHeader(title);
    _content = new CardContent(content);

    _root.classes.add('card');
    _root.append(_header.render);
    _root.append(_content.render);
  }

  CardHeader get header => _header;
  CardContent get content => _content;

  HtmlElement get render => _root;
}

class CardHeader {
  HtmlElement _root;
  HtmlElement _title;

  CardHeader(String title) {
    _setUpComponent(title);
  }

  void _setUpComponent(String title) {
    _root = new DivElement();
    _title = new ParagraphElement();

    _root.classes.add('card-header');
    _title.classes.add('card-header-title');

    _root.append(_title);

    this.title = title;
  }

  void set title(String title) {
    _title.innerHtml = title;
  }

  String get title => _title.innerHtml;

  HtmlElement get render => _root;
}

class CardContent {
  HtmlElement _root;
  HtmlElement _content;

  CardContent(HtmlElement content) {
    _setUpComponent(content);
  }

  void _setUpComponent(HtmlElement content) {
    _root = new DivElement();
    _content = new DivElement();

    _root.classes.add('card-content');
    _content.classes.add('content');

    _root.append(_content);
    this.content = content;
  }

  void set content(HtmlElement content) {
    _content.children.clear();
    _content.append(content);
  }

  HtmlElement get content => _content;

  HtmlElement get render => _root;
}

class CardFooter {}
