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
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "../components"

Page {
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

    title: i18n.tr("Settings")

    Flickable {
        id: flick
        anchors.fill: parent

        flickableDirection: Flickable.VerticalFlick
        contentWidth: column.width
        contentHeight: column.height

        Column {
            width: flick.width
            id: column

            ListItem.Header {
                text: i18n.tr("Beat visualisation")
            }

            ListItem.SingleControl {
                control: OptionSelector {
                    width: parent.width - units.gu(4)

                    text: i18n.tr("Visualisation style")
                    model: [i18n.tr("Rectangle"), i18n.tr("Circle")]

                    Component.onCompleted: selectedIndex = getSetting("visualisationType")
                    onSelectedIndexChanged: {
                        saveSetting("visualisationType", selectedIndex)
                        metronomePage.asignSettings("visualisationType")
                    }
                }
            }

            ListItem.Standard {
                text: i18n.tr("Flash animation")
                control: Switch {
                    Component.onCompleted: checked = (getSetting("flashOn") === '1')
                    onCheckedChanged: {
                        saveSetting("flashOn", +checked)
                        metronomePage.asignSettings("flashOn")
                    }
                }
            }

            ListItem.Header {
                text: i18n.tr("Sound volumes")
            }


            ListItem.Standard {
                text: i18n.tr("Click")
                control: Slider {
                    width: flick.width / 2

                    function formatValue(v) { return v.toFixed(1) }
                    minimumValue: 0
                    maximumValue: 1

                    Component.onCompleted: value = getSetting("clickVolume")
                    onValueChanged: {
                        saveSetting("clickVolume", value)
                        metronomePage.asignSettings("clickVolume")
                    }
                }
            }

            ListItem.Standard {
                text: i18n.tr("Accent")
                control: Slider {
                    width: flick.width / 2

                    function formatValue(v) { return v.toFixed(1) }
                    minimumValue: 0.0
                    maximumValue: 1.0

                    Component.onCompleted: value = getSetting("accentVolume")
                    onValueChanged: {
                        saveSetting("accentVolume", value)
                        metronomePage.asignSettings("accentVolume")
                    }
                }
            }

            ListItem.Divider { }

            ListItem.Standard {
                text: i18n.tr("About")
                progression: true

                onClicked: pageStack.push(aboutPage)
            }
        }
    }
}
