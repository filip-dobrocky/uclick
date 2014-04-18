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
import U1db 1.0 as U1db
import "ui"

/*!
    A simple metronome
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "uclick"
    applicationName: "com.ubuntu.developer.filip-dobrocky.uclick"

    automaticOrientation: true

    headerColor: "#1d6fa5"
    backgroundColor: "#124364"
    footerColor: "#0e344f"

    width: units.gu(45)
    height: units.gu(70)

    U1db.Database { id: db; path: "uclick" }

    U1db.Document {
        id: timeSignDoc
        database: db
        docId: "timeSign"
        create: true
        defaults: { timeSign: "4/4" }
    }

    U1db.Document {
        id: timeSignCountDoc
        database: db
        docId: "timeSignCount"
        create: true
        defaults: { timeSignCount: 4 }
    }

    U1db.Document {
        id: timeSignIndexDoc
        database: db
        docId: "timeSignIndex"
        create: true
        defaults: { timeSignIndex: 2 }
    }

    U1db.Document {
        id: accentSoundDoc
        database: db
        docId: "accentSound"
        create: true
        defaults: { accentSound: 0 }
    }

    U1db.Document {
        id: clickSoundDoc
        database: db
        docId: "clickSound"
        create: true
        defaults: { clickSound: 0 }
    }

    U1db.Document {
        id: bpmDoc
        database: db
        docId: "bpm"
        create: true
        defaults: { bpm: 120 }
    }

    U1db.Document {
        id: accentOnDoc
        database: db
        docId: "accentOn"
        create: true
        defaults: { accentOn: true }
    }

    U1db.Document {
        id: flashOnDoc
        database: db
        docId: "flashOn"
        create: true
        defaults: { flashOn: true }
    }

    U1db.Document {
        id: visualisationTypeDoc
        database: db
        docId: "visualisationType"
        create: true
        defaults: { visualisationType: 0 }
    }

    U1db.Document {
        id: accentVolumeDoc
        database: db
        docId: "accentVolume"
        create: true
        defaults: { accentVolume: 1.0 }
    }

    U1db.Document {
        id: clickVolumeDoc
        database: db
        docId: "clickVolume"
        create: true
        defaults: { clickVolume: 0.8 }
    }

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
