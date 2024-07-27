import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';

final Map<String, Map<String, Color>> defaultCards = {
  'Rojo': {
    '0001 1935 2011 7070': '#DC143C'.toColor(),
  },
  'Morado': {
    '0002 1935 2011 7070': '#800080'.toColor(),
  },
  'Verde': {
    '0003 1935 2011 7070': '#228B22'.toColor(),
  },
  'Azul': {
    '0005 1935 2011 7070': '#4169E1'.toColor(),
  },
  'Azul cielo': {
    '0006 1935 2011 7070': '#87CEEB'.toColor(),
  },
  'Amarillo': {
    '0004 1935 2011 7070': '#FFD700'.toColor(),
  },
};

final List<Color> defaultColors =
    defaultCards.values.map((card) => card.values.first).toList();
