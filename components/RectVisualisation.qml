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

UbuntuShape {
    property ColorAnimation animation: animation

    color: rectColor

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (!timer.running) timer.start()
            else if (timer.running && !startLabel.visible) stopTimer.start()
            else if (timer.running && startLabel.visible) timer.stop()
        }

        Timer {
            id: stopTimer
            interval: 1000
            running: false
            triggeredOnStart: true

            onTriggered: startLabel.stopVisible = !startLabel.stopVisible
        }

        Label {
            id: startLabel
            anchors.centerIn: parent
            visible: !timer.running && !countLabel.visible || stopVisible

            property bool stopVisible

            color: "white"
            text: (!timer.running) ? i18n.tr("Start") : i18n.tr("Stop")
            fontSize: "large"
        }

        Label {
            id: countLabel
            anchors.centerIn: parent
            visible: timer.running && !startLabel.visible

            color: "white"
            font.bold: true
            text: timer.count
            fontSize: "x-large"
        }
    }

    ColorAnimation on color {
        id: animation

        running: false
        from: rectColor
        to: "#00000000"
        duration: 60000/bpmSlider.value
    }
}
