// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    visible: true
    width: 400
    height: 300
    title: "Hello QML"

    property bool isColorChanged: false

    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        color: isColorChanged ? "lightblue" : "lightpink"

        Behavior on color {

            ColorAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on rotation {
            RotationAnimation {
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }

        Text {
            id: greetingText
            text: "Hello, World!"
            anchors.centerIn: parent
            font.pixelSize: 24
            color: "black"
        }

        Button {
            id: changeButton
            text: "Change"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20

            onPressed: {
                isColorChanged = !isColorChanged
                greetingText.text = greetingText.text === "Hello, World!" ? "Hello, Qt!" : "Hello, World!"
                background.rotation = background.rotation === 0 ? 15 : 0
            }
        }
    }
}

