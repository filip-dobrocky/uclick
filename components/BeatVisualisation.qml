/*
 * Copyright (C) 2013 Filip Dobrocky <filip.dobrocky@gmail.com>
 *
 * This file is part of uClick.
 *
 * uClick is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * uClick is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with uClick.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Pickers 0.1

Item {
    property int type: 0
    property color rectColor: "#00000000"
    property bool flashOn
    property variant animation: (type == 0) ? rect.animation : (type == 1) ? circle.animation : null

    RectVisualisation {
        id: rect
        anchors.fill: parent
        visible: (type == 0)
    }

    CircleVisualisation {
        id: circle
        anchors.centerIn: parent
        size: (parent.width < parent.height) ? parent.width : parent.height
        visible: (type == 1)
    }
}
