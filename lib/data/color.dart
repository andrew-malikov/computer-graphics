class Channel {
  int _value;

  Channel(num value) {
    this.value = value;
  }

  int get value => _value;
  void set value(num value) {
    _value = Bound(value, 255);
  }

  String get toString {
    return value.toString();
  }

  String get toHexString {
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

  Map<String, Channel> get channels => _channels;

  String get toRGBString {
    return "rgb(${channels['red'].toString},${channels['green'].toString}," +
        "${channels['blue'].toString})";
  }

  String get toRGBAString {
    return "rgba(${channels['red'].toString},${channels['green'].toString}," +
        "${channels['blue'].toString},${channels['alpha'].toString})";
  }

  String get toRGBHexString {
    return "#${channels['red'].toHexString}${channels['green'].toHexString}" +
        "${channels['blue'].toHexString}";
  }

  String get toRGBAHexString {
    return "#${channels['red'].toHexString}${channels['green'].toHexString}" +
        "${channels['blue'].toHexString}${channels['alpha'].toHexString}";
  }
}

/// return the *int* value between 0 and `maxValue`
int Bound(num value, int maxValue) {
  int resultValue = value.abs();
  return resultValue >= maxValue ? maxValue : resultValue.round();
}

// TODO: Check symbols
bool IsValidHex(String hexValue) {
  return hexValue.length < 1 || hexValue.length > 2;
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
    if (color.length == 3) {
      red = color[0];
      green = color[1];
      blue = color[2];
    }
    if (color.length == 6) {
      red = color.substring(0, 2);
      green = color.substring(2, 4);
      blue = color.substring(4);
    }
    if (red.isEmpty || green.isEmpty || blue.isEmpty)
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
    if (color.length == 4) {
      rgbaColor = ColorBuilder.FullRGBHex(color.substring(0, 3));
      alpha = color.substring(3);
    }
    if (color.length == 8) {
      rgbaColor = ColorBuilder.FullRGBHex(color.substring(0, 6));
      alpha = color.substring(6);
    }
    if (alpha.isEmpty)
      throw new ArgumentError("Cannot use invalid value: $color");
    rgbaColor.channels['alpha'] = ChannelBuilder.Hex(alpha);
    return rgbaColor;
  }
}
