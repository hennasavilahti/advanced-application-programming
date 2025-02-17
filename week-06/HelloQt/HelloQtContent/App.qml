// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls
import HelloQt

Window {
    // Propertyjä
    width: 800
    height: 400
    visible: true
    title: "HelloQt"

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "blue" }
            GradientStop { position: 1.0; color: "white" }
        }
    }

    // Lisätään ikkunaan käyttöliittymäelementti
    // Esimerkkejä: Rectangle, Button, Text

    Rectangle {
        id: mainRectangle
        x: 30
        y: 100
        width: 100
        height: 200
        color: "blue"
        border.color: "black"
        border.width: 5
        radius: 30
    }

    Rectangle {
        id: otherRectangle
        x: 60
        y: 100
        width: 200
        height: 100
        color: "red"
        border.color: "black"
        border.width: 5
        radius: 30
        MouseArea{
            // Täytetään koko Rectangle mouse arealla
            anchors.fill: parent
            onClicked: {
                // Vaihdetaan Rectanglen väri ja käännetään sitä 90 astetta
                otherRectangle.color = "yellow";
                otherRectangle.rotation += 90;
                otherRectangle.x += 20;
                mainRectangle.scale *= 1.1
            }
        }
    }

    Rectangle {
        id: myButton
        height: 50
        width: 120
        anchors.centerIn: parent
        color: "grey"
        Text {
            text: "Click me!"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onPressed: {
                myButton.scale = 0.9
                myButton.color = "lightblue"
            }
            onReleased: {
                myButton.scale = 1.0
                myButton.color = "grey"
                otherRectangle.color = "green"
            }
        }
    }


}

