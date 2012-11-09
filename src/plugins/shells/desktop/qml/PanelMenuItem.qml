/****************************************************************************
 * This file is part of Desktop Shell.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0
import FluidCore 1.0
import FluidUi 1.0

Item {
    id: root

    property alias text: label.text
    property alias font: label.font

    property real padding: 8

    signal clicked

    /*
    implicitWidth: label.paintedWidth + padding
    implicitHeight: label.paintedHeight + padding
    */
    implicitWidth: 150
    implicitHeight: 50
    width: Math.max(implicitWidth, parent.width)

    Keys.onReturnPressed: root.clicked()

    Rectangle {
        id: container
        //anchors.centerIn: parent
        anchors.fill: parent
        color: "transparent"

        Label {
            id: label
            anchors.fill: parent
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            label.color = theme.highlightedTextColor;
            container.color = theme.highlightColor;
        }
        onExited: {
            label.color = theme.windowTextColor;
            container.color = "transparent";
        }
        onClicked: root.clicked()
    }
}
