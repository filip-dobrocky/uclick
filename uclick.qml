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
import "ui"

/*!
    A simple metronome
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "uclick"
    applicationName: "com.ubuntu.developer.filip-dobrocky.uclick"

    automaticOrientation: true

    headerColor: "#0c3d3b"
    backgroundColor: "#082826"
    footerColor: "#041212"

    width: units.gu(45)
    height: units.gu(70)

    PageStack {
        id: pageStack

        Component.onCompleted: push(metronomePage)

        MetronomePage {
            id: metronomePage
            visible: false
        }

        SettingsPage {
            id: settingsPage
            visible: false
        }

        AboutPage {
            id: aboutPage
            visible: false
        }
    }
}
