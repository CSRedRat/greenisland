/****************************************************************************
 * This file is part of Desktop Shell.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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
import QtQuick.Window 2.0
import GreenIsland 1.0

QtObject {
    id: root

    // Screen geometry
    property rect geometry

    // Available screen geometry
    property rect availableGeometry

    property var launcher: Launcher {
        objectName: "launcher"
    }

    property var panel: Panel {
        objectName: "panel"
    }

    property var background: Background {
        objectName: "background"
    }

    property var appChooser: AppChooser {
        objectName: "appChooser"
        /*
        width: availableGeometry.width / 1.2
        height: availableGeometry.height / 1.2
        */
    }

/*
    // Notifications panel
    NotificationsPanel {
        id: notificationsPanel
        x: root.width
        y: panelComponent.height
        z: 3
        width: root.width / 4
        height: root.height
        visible: false

        // Animation
        Behavior on x {
            NumberAnimation { duration: 200 }
        }

        function show() {
            visible = true;
            x = root.width - width;
        }

        function hide() {
            x = root.width;
        }
    }
*/
}
