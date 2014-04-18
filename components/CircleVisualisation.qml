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

Dialer {
    property variant animation: (flashOn) ? flashAnimation : animation

    centerContent: [RectVisualisation {
            id: rect
            width: parent.width / 2; height: width
            anchors.centerIn: parent
    }]

    DialerHand {
        id: hand

        hand.width:  units.gu(2)
        hand.height: units.gu(5)
    }

    ParallelAnimation {
        id: flashAnimation

        NumberAnimation {
            target: hand
            property: "value"

            running: false
            duration: 60000/bpmSlider.value
            from: 0
            to: 360
        }

        ColorAnimation {
            target: rect
            property: "color"

            running: false
            from: rectColor
            to: rect.transparentColor
            duration: 60000/bpmSlider.value
        }
    }

    NumberAnimation {
        id: animation
        target: hand
        property: "value"

        running: false
        duration: 60000/bpmSlider.value
        from: 0
        to: 360
    }
}
