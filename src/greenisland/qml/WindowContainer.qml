/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Window 2.0

Item {
    id: container

    property real targetX
    property real targetY
    property real targetWidth
    property real targetHeight
    property real targetScale

    property real originalX
    property real originalY

    property variant child: null
    property variant chrome: null
    property int index
    property bool animationsEnabled: true

    x: targetX
    y: targetY
    width: targetWidth
    height: targetHeight
    scale: targetScale
    state: child && chrome && chrome.selected && child.focus ? "selected" : "normal"

    Behavior on x {
        enabled: container.animationsEnabled;
        NumberAnimation { easing.type: Easing.InCubic; duration: 200; }
    }

    Behavior on y {
        enabled: container.animationsEnabled;
        NumberAnimation { easing.type: Easing.InQuad; duration: 200; }
    }

    Behavior on width {
        enabled: container.animationsEnabled;
        NumberAnimation { easing.type: Easing.InCubic; duration: 200; }
    }

    Behavior on height {
        enabled: container.animationsEnabled;
        NumberAnimation { easing.type: Easing.InCubic; duration: 200; }
    }

    Behavior on scale {
        enabled: container.animationsEnabled;
        NumberAnimation { easing.type: Easing.InQuad; duration: 200; }
    }

    Behavior on opacity {
        enabled: true;
        NumberAnimation { easing.type: Easing.Linear; duration: 250; }
    }

    // Decrease opacity for unfocused windows
    ContrastEffect {
        id: effect
        source: child
        anchors.fill: child
        blend: { if (child && chrome && (chrome.selected || child.focus)) 0.0; else 0.9 }
        opacity: 1.0
        z: 1

        Behavior on blend {
            enabled: true
            NumberAnimation { easing.type: Easing.Linear; duration: 250; }
        }
    }

    transitions: [
        Transition {
            from: "*"; to: "normal"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        compositor.currentSurface = null
                    }
                }
                ScriptAction {
                    script: container.z = 0
                }
            }
        },
        Transition {
            from: "*"; to: "selected"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        container.z = 1
                    }
                }
                ScriptAction {
                    script: compositor.currentSurface = child.surface
                }
            }
        }
    ]
}
