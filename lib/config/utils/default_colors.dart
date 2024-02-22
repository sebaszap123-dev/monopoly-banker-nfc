import 'package:flutter/material.dart';

final Map<String, Map<String, Color>> defaultCards = {
  'Rojo': {
    '0001 1935 2011 7070': Colors.red.shade800,
  },
  'Morado': {
    '0002 1935 2011 7070': Colors.purpleAccent.shade700,
  },
  'Verde': {
    '0003 1935 2011 7070': Colors.green.shade500,
  },
  'Azul': {
    '0005 1935 2011 7070': Colors.blue.shade900,
  },
  'Azul cielo': {
    '0006 1935 2011 7070': Colors.blue.shade200,
  },
  'Amarillo': {
    '0004 1935 2011 7070': Colors.yellowAccent.shade700,
  },
};

final List<Color> defaultColors =
    defaultCards.values.map((card) => card.values.first).toList();
