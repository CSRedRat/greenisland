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
import FluidCore 1.0

Window {
    id: backgroundWindow
    x: 0
    y: 0
    width: 1
    height: 1
    title: "Hawaii Background"

    Settings {
        id: settings
        schema: "org.hawaii.desktop"
        group: "background"
        onValueChanged: loadSettings()
    }

    // Desktop wallpaper
    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: settings.value("wallpaper-uri")
        smooth: true
    }

    function loadSettings() {
        background.source = settings.value("wallpaper-uri");
    }
}
