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

PanelIndicator {
    // Settings
    // TODO: Read from settings
    property int format: Locale.LongFormat
    property bool showSeconds: true

    // Current date and time
    property date now

    label: {
        var l = Qt.formatDate(now, Qt.locale().dateFormat(format));
        l += " " + Qt.formatTime(now, "HH:mm" + (showSeconds ? ":ss" : ""));
        return l;
    }

    Timer {
        id: timer
        running: false
        interval: showSeconds ? 500 : 1000
        repeat: true
        onTriggered: {
            now = new Date();
        }
    }

    Component.onCompleted: {
        now = new Date();
        timer.running = true;
    }
}
