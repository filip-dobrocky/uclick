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
import QtQuick.LocalStorage 2.0
import QtMultimedia 5.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import "../components"

Page {
    // VARIABLES
    property double accentVolume: 1
    property double clickVolume: 0.8

    // DATABASE
    property var db: null

    function openDB() {
        if(db !== null) return;

        // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
        db = LocalStorage.openDatabaseSync("uclick", "0.1", "uClick settings", 100000);

        try {
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value TEXT)');
                var table  = tx.executeSql("SELECT * FROM settings");
                // seed the table with default values
                if (table.rows.length === 0) {
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["timeSign", "4/4"]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["timeSignCount", 4]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["timeSignIndex", 2]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["accentSound", 0]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["clickSound", 0]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["bpm", 120]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["accentOn", 1]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["flashOn", 1]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["visualisationType", 0]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["accentVolume", 1.0]);
                    tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["clickVolume", 0.8]);
                    console.log('Settings table added');
                };
            });
        } catch (err) {
            console.log("Error creating table in database: " + err);
        };
    }

    function saveSetting(key, value) {
        openDB();
        db.transaction( function(tx){
            tx.executeSql('INSERT OR REPLACE INTO settings VALUES(?, ?)', [key, value]);
        });
    }

    function getSetting(key) {
        openDB();
        var res = "";
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT value FROM settings WHERE key=?;', [key]);
            res = rs.rows.item(0).value;
        });
        return res;
    }

    function asignSettings(setting) {
        switch (setting) {
        case "visualisationType":
            visualisation.type = getSetting("visualisationType")
            break;
        case "flashOn":
            visualisation.flashOn = (getSetting("flashOn") === '1')
            break;
        case "accentVolume":
            accentVolume = getSetting("accentVolume")
            break;
        case "clickVolume":
            clickVolume = getSetting("clickVolume")
            break;
        default:
            timeSignSheet.timeSign = getSetting("timeSign")
            timeSignSheet.timeSignCount = getSetting("timeSignCount")
            timeSignSheet.timeSignIndex = getSetting("timeSignIndex")
            soundSheet.accentSound = getSetting("accentSound")
            soundSheet.clickSound = getSetting("clickSound")
            bpmSlider.value = getSetting("bpm")
            accentSwitch.checked = (getSetting("accentOn") === '1')
            visualisation.type = getSetting("visualisationType")
            visualisation.flashOn = (getSetting("flashOn") === '1')
            accentVolume = getSetting("accentVolume")
            clickVolume = getSetting("clickVolume")
        }
    }

    // on startup
    Component.onCompleted: asignSettings()

    // FUNCTIONS
    function playClick(sound) {
        switch (sound) {
        case 0:
            clickSine.play()
            break;
        case 1:
            clickPluck.play()
            break;
        case 2:
            clickBass.play()
            break;
        }
    }

    function playAccent(sound) {
        switch (sound) {
        case 0:
            accentSine.play()
            break;
        case 1:
            accentPluck.play()
            break;
        case 2:
            accentBass.play()
            break;
        }
    }

    function italian(tempo) {
        if (tempo < 40) return "Larghissimo"
        else if (tempo >= 40 && tempo < 60) return "Largo"
        else if (tempo >= 60 && tempo < 66) return "Larghetto"
        else if (tempo >= 66 && tempo < 76) return "Adagio"
        else if (tempo >= 76 && tempo < 108) return "Adante"
        else if (tempo >= 108 && tempo < 120) return "Modernato"
        else if (tempo >= 120 && tempo < 168) return "Allegro"
        else if (tempo >= 168 && tempo < 208) return "Presto"
        else if (tempo >= 208) return "Prestissimo"
    }

    title: i18n.tr("Metronome")

    tools: ToolbarItems {
        ToolbarButton {
            iconSource: "../icons/settings.svg"
            text: i18n.tr("Settings")

            onTriggered: pageStack.push(settingsPage)
        }

        ToolbarButton {
            iconSource: "../icons/sound.svg"
            text: i18n.tr("Sound")

            onTriggered: PopupUtils.open(soundSheet.component)
        }

        ToolbarButton {
            iconSource: "../icons/time-signature.svg"
            text: timeSignSheet.timeSign

            onTriggered: PopupUtils.open(timeSignSheet.component)
        }

        ToolbarButton {
            id: accentSwitch

            iconSource: (checked) ? "../icons/accent-on.svg" : "../icons/accent-off.svg"
            text: (checked) ? i18n.tr("Accent") : i18n.tr("No accent")

            property bool checked

            onTriggered: {
                checked = !checked
                saveSetting("accentOn", +accentSwitch.checked)
            }
        }
    }

    TimeSignSheet {
        id: timeSignSheet
    }

    SoundSheet {
        id: soundSheet
    }

    BeatVisualisation {
        id: visualisation
        anchors {
            top: parent.top
            bottom: mainColumn.top
            right: parent.right
            left: parent.left
            margins: units.gu(1)
        }
    }

    Column {
        id: mainColumn
        anchors {
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            margins: units.gu(1)
        }
        spacing: units.gu(1)

        Button {
            width: parent.width; height: units.gu(8)

            color: UbuntuColors.orange
            text: i18n.tr("Tap")

            property double millis: 0
            property double lastMillis: 0
            property double taps: 0
            property double lastTap: 0
            property int i: 1

            onClicked: {
                /* on each tap, it calculates the average of all of the taps,
                    if there's a big difference, it resets the tempo */

                var date = new Date()

                if (lastTap != 0) {
                    millis = date.getTime() - lastTap
                    lastTap = date.getTime()

                    // if the difference between taps is greater than 1/5, reset
                    if (lastMillis != 0 && Math.abs(lastMillis-millis) > lastMillis/5) {
                        i = 1
                        taps = lastTap = millis = lastMillis = 0
                        return
                    }

                    lastMillis = millis

                    taps += (60000/millis)

                    // set tempo to the average of the taps
                    bpmSlider.value = (taps/i > 300) ? 300 : taps/i
                    i++
                } else
                    lastTap = date.getTime()
            }
        }



        Label {
            text: i18n.tr("Tempo") + ": " + bpmSlider.value.toFixed() + " BPM" + " (" + italian(bpmSlider.value.toFixed()) + ")"
        }

        Slider {
            id: bpmSlider
            width: parent.width

            minimumValue: 30
            maximumValue: 300
            value: 30

            onValueChanged: saveSetting("bpm", bpmSlider.value)
        }
    }

    SoundEffect {
        id: clickSine
        source: "../sounds/click_sine.wav"
        volume: clickVolume
    }

    SoundEffect {
        id: accentSine
        source: "../sounds/accent_sine.wav"
        volume: accentVolume
    }

    SoundEffect {
        id: clickPluck
        source: "../sounds/click_pluck.wav"
        volume: clickVolume
    }

    SoundEffect {
        id: accentPluck
        source: "../sounds/accent_pluck.wav"
        volume: accentVolume
    }

    SoundEffect {
        id: clickBass
        source: "../sounds/click_bass.wav"
        volume: clickVolume
    }

    SoundEffect {
        id: accentBass
        source: "../sounds/accent_bass.wav"
        volume: accentVolume
    }

    Timer {
        id: timer
        interval: 60000/bpmSlider.value
        running: false
        repeat: true
        triggeredOnStart: true

        property int count: 0

        onTriggered: {
            count = (count < timeSignSheet.timeSignCount) ? ++count : 1

            if (count == 1 && accentSwitch.checked) {
                visualisation.rectColor = "green"
                playAccent(soundSheet.accentSound)
            } else {
                visualisation.rectColor = "red"
                playClick(soundSheet.clickSound)
            }

            if (visualisation.flashOn || visualisation.type == 1) visualisation.animation.restart()
        }

        onRunningChanged: if (!running) count = 0
    }
}
