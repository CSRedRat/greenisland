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
import FluidCore 1.0 as FluidCore
import FluidUi 1.0 as FluidUi
import GreenIsland 1.0

ModalDialog {
    property string actionId
    property alias message: messageText.text
    property string iconName
    property variant details
    property variant defaultIdentity: null
    property variant identities
    property alias prompt: promptLabel.text
    property bool echo: false
    property alias response: passwordInput.text

    title: Item {
        Image {
            id: dialogIcon
            anchors {
                left: parent.left
                top: parent.top
            }
            source: "image://desktoptheme/dialog-password-symbolic"
            sourceSize: Qt.size(theme.largeIconSize, theme.largeIconSize)
        }

        FluidUi.Label {
            anchors {
                left: dialogIcon.right
                verticalCenter: dialogIcon.verticalCenter
                leftMargin: 10
            }
            text: qsTr("Authentication Required")
            font.weight: Font.Bold
        }
    }
    content: Item {
        width: 320
        height: 260

        FluidUi.Label {
            id: messageText
            anchors {
                left: parent.left
                top: parent.top
                right: parent.right
                topMargin: 35
            }
            wrapMode: Text.Wrap
            height: theme.defaultFont.mSize * 4
        }

        ListView {
            id: usersView
            anchors {
                left: parent.left
                top: messageText.bottom
                right: parent.right
                bottom: passwordInput.top
            }
            model: identities
            delegate: FluidUi.ListItem {
                Image {
                    id: userImage
                    anchors {
                        left: parent.left
                        top: parent.top
                        rightMargin: 10
                    }
                    source: "image://desktoptheme/" + modelData.iconFileName
                    sourceSize: Qt.size(theme.largeIconSize, theme.largeIconSize)
                    onStatusChanged: {
                        // Fallback to a standard icon in case we can't load user's icon
                        if (status == Image.Error)
                            source = "image://desktoptheme/avatar-default";
                    }
                }

                FluidUi.Label {
                    id: userLabel
                    anchors {
                        left: userImage.right
                        verticalCenter: userImage.verticalCenter
                    }
                    text: modelData.displayName
                    font.weight: Font.Bold
                }
            }
            clip: true
        }

        FluidUi.Label {
            id: promptLabel
            anchors {
                left: parent.left
                verticalCenter: passwordInput.verticalCenter
            }
        }

        FluidUi.TextField {
            id: passwordInput
            anchors {
                left: promptLabel.right
                right: usersView.right
                bottom: parent.bottom
                bottomMargin: 12
            }
            //echoMode: echo ? TextInput.Password : TextInput.Normal
            echoMode: TextInput.Password
        }
    }
    buttons: [
        FluidUi.Button {
            id: cancelButton
            anchors {
                left: parent.left
                top: parent.top
            }
            text: qsTr("Cancel")
            onClicked: reject()
        },
        FluidUi.Button {
            id: authenticateButton
            anchors {
                top: parent.top
                right: parent.right
            }
            text: qsTr("Authenticate")
            onClicked: accept()
        }
    ]
}
