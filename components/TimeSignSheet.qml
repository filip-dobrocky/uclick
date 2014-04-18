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
import Ubuntu.Components.Popups 0.1

Item {
    property string timeSign
    property int timeSignCount
    property int timeSignIndex
    property Component component: timeSignComponent

    Component {
        id: timeSignComponent

        ComposerSheet {
            title: i18n.tr("Time signature")
            onConfirmClicked: {
                if (custom.text != "0" && custom.text != ""
                        && custom.text != "00") {
                    timeSignCount = custom.text
                    timeSign = timeSignCount + " " + i18n.tr("click", "clicks", timeSignCount)
                } else {
                    switch(timeSign) {
                    case "2/4":
                        timeSignCount = 2
                        break;
                    case "3/4":
                        timeSignCount = 3
                        break;
                    case "4/4":
                        timeSignCount = 4
                        break;
                    case "5/4":
                        timeSignCount = 5
                        break;
                    case "6/8":
                        timeSignCount = 6
                        break;
                    case "7/8":
                        timeSignCount = 7
                        break;
                    }
                }
            }

            UbuntuShape {
                anchors.fill: parent
                color: backgroundColor

                Row {
                    spacing: units.gu(1)
                    anchors {
                        fill: parent
                        margins: units.gu(1)
                    }

                    OptionSelector {
                        model: ["2/4", "3/4", "4/4", "5/4", "6/8", "7/8"]
                        width: (parent.width-units.gu(1))/2
                        containerHeight: parent.height
                        expanded: true
                        selectedIndex: timeSignIndex
                        onSelectedIndexChanged: {
                            if (model !== undefined) timeSign = model[selectedIndex]
                            timeSignIndex = selectedIndex
                        }
                    }

                    Column {
                        spacing: units.gu(1)
                        width: (parent.width-units.gu(1))/2

                        Label {
                            text: i18n.tr("Custom") + ":"
                        }

                        TextField {
                            id: custom
                            inputMask: "99"
                            width: parent.width
                            hasClearButton: false
                            placeholderText: i18n.tr("Clicks per bar")
                        }
                    }
                }
            }
        }
    }
}
