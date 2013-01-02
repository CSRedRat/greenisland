/****************************************************************************
 * This file is part of Green Island.
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
import FluidCore 1.0
import "CompositorLogic.js" as CompositorLogic

Item {
    id: root

    // Currently selected window
    property variant selectedWindow: null

    // True if we're using the normal layout
    property bool normalLayout: true

    // Relayout windows
    onWidthChanged: CompositorLogic.relayout()
    onHeightChanged: CompositorLogic.relayout()

    // Opacity will be set to 1.0 by the fade-in animation
    opacity: 0.0

    Settings {
        id: bgSettings
        schema: "org.hawaii.desktop"
        group: "background"
        onValueChanged: {
            // Change wallpaper image
            backgroundChangeAnim.start();
        }
    }

    // Fade-in animation for the whole screen
    NumberAnimation on opacity {
        easing.type: Easing.Linear
        duration: 1500
        to: 1.0
    }

    SequentialAnimation {
        id: backgroundChangeAnim

        NumberAnimation {
            target: background
            property: "opacity"
            duration: 250
            easing.type: Easing.Linear
            to: 0.0
        }
        ScriptAction {
            script: background.source = bgSettings.value("wallpaper-uri")
        }
        NumberAnimation {
            target: background
            property: "opacity"
            duration: 250
            easing.type: Easing.Linear
            to: 1.0
        }
    }

    // Desktop wallpaper
    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: bgSettings.value("wallpaper-uri")
        smooth: true
    }

    function windowAdded(window) {
        CompositorLogic.windowAdded(root, window);
    }

    function windowResized(window) {
        CompositorLogic.windowResized(window);
    }

    function windowDestroyed(window) {
        CompositorLogic.windowDestroyed(window);
    }

    function removeWindow(window) {
        CompositorLogic.windowRemoved(compositor, window);
    }
}
