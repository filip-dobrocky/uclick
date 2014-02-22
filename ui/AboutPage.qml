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

Page {
    property string version: "1.3"

    title: i18n.tr("About")

    Column {
        anchors {
            fill: parent
            margins: units.gu(1)
        }

        spacing: units.gu(1)

        Label {
            anchors.horizontalCenter: parent.horizontalCenter

            text: "uClick"
            fontSize: "large"
        }

        UbuntuShape {
            width: units.gu(10); height: units.gu(10)
            anchors.horizontalCenter: parent.horizontalCenter

            radius: "medium"
            image: Image {
                source: Qt.resolvedUrl("../icons/uclick.png")
            }
        }

        Label {
            width: parent.width

            linkColor: UbuntuColors.orange
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "<b>Version:</b> " + version + "<br><br>
uClick is a simple metronome app for Ubuntu."


            onLinkActivated: Qt.openUrlExternally(link)
        }

        Label {
            width: parent.width

            linkColor: UbuntuColors.orange
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "<b>Author:</b> Filip Dobrocký<br>
<b>Contact:</b> <a href=\"https://plus.google.com/u/0/106056788722129106018/posts\">Filip Dobrocký (Google Plus)</a><br>
<b>License:</b> <a href=\"http://www.gnu.org/licenses/gpl.txt\">GNU GPL v3</a><br>
<b>Source code:</b> <a href=\"https://github.com/filip-dobrocky/uclick\">GitHub</a>"

            onLinkActivated: Qt.openUrlExternally(link)
        }

        Label {
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            text: "<b>Copyright (C) 2014 Filip Dobrocký &lt;filip.dobrocky@gmail.com&gt;</b>"
        }
    }
}
