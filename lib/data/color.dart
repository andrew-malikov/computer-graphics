class Channel {
  int _value;

  Channel(num value) {
    this.value = value;
  }

  Channel get clone => new Channel(value);

  int get value => _value;
  void set value(num value) {
    _value = Bound(value, 255);
  }

  String toString() {
    return value.toString();
  }

  String toHexString() {
    return value.toRadixString(16);
  }
}

class Color {
  Map<String, Channel> _channels;

  Color(Channel red, Channel green, Channel blue, Channel alpha) {
    _channels = new Map<String, Channel>();
    _channels['red'] = red;
    _channels['green'] = green;
    _channels['blue'] = blue;
    _channels['alpha'] = alpha;
  }

  void update(Color color) {
    channels['red'] = color.channels['red'].clone;
    channels['green'] = color.channels['green'].clone;
    channels['blue'] = color.channels['blue'].clone;
    channels['alpha'] = color.channels['alpha'].clone;
  }

  Color get clone {
    Channel red = channels['red'].clone;
    Channel green = channels['green'].clone;
    Channel blue = channels['blue'].clone;
    Channel alpha = channels['alpha'].clone;
    return new Color(red, green, blue, alpha);
  }

  Map<String, Channel> get channels => _channels;

  String toRGBString() {
    return "rgb(${channels['red'].toString()},${channels['green'].toString()}," +
        "${channels['blue'].toString()})";
  }

  String toRGBAString() {
    return "rgba(${channels['red'].toString()},${channels['green'].toString()}," +
        "${channels['blue'].toString()},${channels['alpha'].toString()})";
  }

  String toRGBHexString() {
    return "#${channels['red'].toHexString()}${channels['green'].toHexString()}" +
        "${channels['blue'].toHexString()}";
  }

  String toRGBAHexString() {
    return "#${channels['red'].toHexString()}${channels['green'].toHexString()}" +
        "${channels['blue'].toHexString()}${channels['alpha'].toHexString()}";
  }
}

/// return the *int* value between 0 and `maxValue`
int Bound(num value, int maxValue) {
  int resultValue = value.abs();
  return resultValue >= maxValue ? maxValue : resultValue.round();
}

// TODO: Check symbols
bool IsValidHex(String hexValue) {
  return hexValue.length >= 1 && hexValue.length <= 2;
}

String RecoverHex(String hexValue) {
  return hexValue.length == 1 ? "$hexValue$hexValue" : hexValue;
}

class ChannelBuilder {
  static Channel Hex(String hexValue) {
    if (!IsValidHex(hexValue))
      throw new ArgumentError("Cannot use invalid value: $hexValue");
    return new Channel(int.parse(RecoverHex(hexValue), radix: 16));
  }
}

class ColorBuilder {
  static Color RGB(int red, int green, int blue) {
    return new Color(new Channel(red), new Channel(green), new Channel(blue),
        new Channel(255));
  }

  static Color RGBA(int red, int green, int blue, int aplha) {
    return new Color(new Channel(red), new Channel(green), new Channel(blue),
        new Channel(aplha));
  }

  static Color RGBHex(String red, String green, String blue) {
    Channel redChannel = ChannelBuilder.Hex(red);
    Channel greenChannel = ChannelBuilder.Hex(green);
    Channel blueChannel = ChannelBuilder.Hex(blue);
    return new Color(redChannel, greenChannel, blueChannel, new Channel(255));
  }

  static Color FullRGBHex(String color) {
    String red, green, blue;
    if (color.length == 4) {
      red = color[1];
      green = color[2];
      blue = color[3];
    }
    if (color.length == 7) {
      red = color.substring(1, 3);
      green = color.substring(3, 5);
      blue = color.substring(5);
    }
    if (red == null || green == null || blue == null)
      throw new ArgumentError("Cannot use invalid value: $color");
    return ColorBuilder.RGBHex(red, green, blue);
  }

  static Color RGBAHex(String red, String green, String blue, String alpha) {
    Color color = ColorBuilder.RGBHex(red, green, blue);
    color.channels['alpha'] = ChannelBuilder.Hex(alpha);
    return color;
  }

  static Color FullRGBAHex(String color) {
    String alpha;
    Color rgbaColor;
    if (color.length == 5) {
      rgbaColor = ColorBuilder.FullRGBHex(color.substring(1, 4));
      alpha = color.substring(4);
    }
    if (color.length == 9) {
      rgbaColor = ColorBuilder.FullRGBHex(color.substring(1, 7));
      alpha = color.substring(7);
    }
    if (alpha == null)
      throw new ArgumentError("Cannot use invalid value: $color");
    rgbaColor.channels['alpha'] = ChannelBuilder.Hex(alpha);
    return rgbaColor;
  }
}
