// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick

Window {
    id: mainWindow
    width: 800
    height: 600

    property color currentColor: "lavenderblush"

    Rectangle {
        id: windowBackground
        anchors.fill: parent
        color: currentColor

        Column {
            anchors.centerIn: parent
            spacing: 5

            Image {
                id: catImage
                width: 170
                height: 180
                source: "images/cat2.png"
            }

            Button {
                buttonText: "Rotate right"
                onButtonClicked: {
                     catImage.rotation -= 45
                }
            }

            Button {
               buttonText: "Rotate left"
               onButtonClicked: {
                    catImage.rotation += 45
               }
            }

            Button {
                buttonText: "Try me!"
                onButtonClicked: {
                    currentColor = Qt.colorEqual(currentColor, "lavenderblush") ? "pink" : "lavenderblush"
                    buttonText = buttonText === "Try me!" ? "Try again!" : "Try me!"
                }
            }
        }
    }


}

