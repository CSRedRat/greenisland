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
    id: contextMenuItem

    default property alias items: contentsItem.children

    property real padding: 4

    signal clicked

    implicitWidth: Math.max(contentsItem.width, contentsItem.implicitWidth) + (padding * 2)
    implicitHeight: Math.max(contentsItem.height, contentsItem.implicitHeight) + (padding * 2)
    width: Math.max(implicitWidth, parent.width)

    Keys.onReturnPressed: contextMenuItem.clicked()

    Row {
        id: contentsItem
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: padding
            topMargin: padding
            rightMargin: padding
            bottomMargin: padding
        }
        onChildrenChanged: {
            // Trigger the clicked() signal for child items too
            for (var i = 0; i < children.length; ++i) {
                if (children[i].clicked != undefined)
                    children[i].clicked.connect(contextMenuItem.clicked)
            }
        }
    }
}
