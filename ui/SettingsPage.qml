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
                    selectedIndex: visualisationTypeDoc.contents.visualisationType || 0
                    model: [i18n.tr("Rectangle"), i18n.tr("Circle")]

                    onSelectedIndexChanged: visualisationTypeDoc.contents = { visualisationType: selectedIndex }
                }
            }

            ListItem.Standard {
                text: i18n.tr("Flash animation")
                control: Switch {
                    checked: (flashOnDoc.contents.flashOn !== undefined) ? flashOnDoc.contents.flashOn : true

                    onCheckedChanged: flashOnDoc.contents = { flashOn: checked }
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
                    value: (clickVolumeDoc.contents.clickVolume !== undefined) ? clickVolumeDoc.contents.clickVolume : 0.8

                    onValueChanged: clickVolumeDoc.contents = { clickVolume: value }
                }
            }

            ListItem.Standard {
                text: i18n.tr("Accent")
                control: Slider {
                    width: flick.width / 2

                    function formatValue(v) { return v.toFixed(1) }
                    minimumValue: 0.0
                    maximumValue: 1.0
                    value: (accentVolumeDoc.contents.accentVolume !== undefined) ? accentVolumeDoc.contents.accentVolume : 1.0

                    onValueChanged: accentVolumeDoc.contents = { accentVolume: value }
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
