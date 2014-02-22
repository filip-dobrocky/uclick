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
    property int clickSound
    property int accentSound
    property Component component: soundComponent

    Component {
        id: soundComponent

        DefaultSheet {
            doneButton: true
            title: i18n.tr("Sound")
            onDoneClicked: {
                clickSound = selectorClick.selectedIndex
                accentSound = selectorAccent.selectedIndex

                saveSetting("accentSound", accentSound)
                saveSetting("clickSound", clickSound)
            }

            UbuntuShape {
                anchors.fill: parent
                color: "#082826"

                Row {
                    spacing: units.gu(1)
                    anchors {
                        fill: parent
                        margins: units.gu(1)
                    }

                    OptionSelector {
                        id: selectorClick
                        width: (parent.width-units.gu(1))/2
                        containerHeight: parent.height
                        text: i18n.tr("Click")
                        expanded: true
                        model: [i18n.tr("Sine"), i18n.tr("Pluck"), i18n.tr("Bass")]
                        selectedIndex: clickSound
                    }

                    OptionSelector {
                        id: selectorAccent
                        width: (parent.width-units.gu(1))/2
                        containerHeight: parent.height
                        text: i18n.tr("Accent")
                        expanded: true
                        model: [i18n.tr("Sine"), i18n.tr("Pluck"), i18n.tr("Bass")]
                        selectedIndex: accentSound
                    }
                }
            }
        }
    }
}
