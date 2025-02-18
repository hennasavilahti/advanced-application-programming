// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import SimpleTrafficlights

Window {
    width: 800
    height: 600

    property bool isStopped: true

    Rectangle {
        anchors.fill: parent
        color: "lavenderblush"

        TrafficLights {
            id: lights
            anchors.centerIn: parent
            trafficLightsBlinking: false
            trafficLightsOn: true
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 30
            spacing: 5

            Button {
                buttonText: lights.trafficLightsOn ? "Stop" : "Start"

                onButtonClicked: {
                    lights.trafficLightsOn = !lights.trafficLightsOn
                }
            }

            Button {
                buttonText: "Switch"

                onButtonClicked: {
                    lights.trafficLightsBlinking = !lights.trafficLightsBlinking
                }

            }
        }


    }
}

