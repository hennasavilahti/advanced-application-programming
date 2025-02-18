// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls

Window {
    id: mainWindow
    width: 800
    height: 600

    visible: true
    title: "WeatherDisplay"

    property color gradientStopColor: "blue"
    property string weatherLocationString: "Tampere"
    property color currentColor: "black"
    property string currentWeather: "clouds"
    property real currentTemperature: 20

    // Funktio, joka vaihtaa taustan väriä lämpötilan mukaan
    function updateBackground() {
        if (currentTemperature < 0) {
            gradientStopColor = "deepskyblue"
        } else if (currentTemperature >= 20) {
            gradientStopColor = "indianred"
        } else  if (currentTemperature > 10){
            gradientStopColor = "darksalmon"
        } else {
            gradientStopColor = "khaki"
        }
    }


    // Tausta, joka täyttää ikkunan ja sen taustaväri on gradient
    Rectangle {
        id: windowBackground
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#ffffff";
            }
            GradientStop {
                position: 1.00;
                color: gradientStopColor;
            }
        }

        Text {
            id: weatherLocationText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            text: weatherLocationString
            color: currentColor
            font.pixelSize: 50
            font.family: "Arial"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentColor = Qt.colorEqual(currentColor, "black") ? "gray" : "black"
                }
            }
        }

        Row {
            id: weatherInfoRow
            anchors.top: weatherLocationText.bottom
            anchors.topMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 100

            Image {
                id: image
                width: 200
                height: 200
                source: "images/" + currentWeather + ".png"
            }


            Column {
                id: weatherDetailsColum
                anchors.verticalCenter: image.verticalCenter
                spacing: 20

                Text {
                    id: weatherText
                    text: currentWeather
                    font.pixelSize: 40
                    font.family: "Arial"
                }

                Text {
                    id: temperatureText
                    text: currentTemperature + " C"
                    font.pixelSize: 40
                    font.family: "Arial"
                }

                Text {
                    id: windSpeedText
                    text: "3 m/s"
                    font.pixelSize: 40
                    font.family: "Arial"
                }
            }
        }

        Button {
            id: updateButton
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 100
            text: "Update Temperature"
            onClicked: {
                // Satunnaisesti generoitu lämpötila
                currentTemperature = Math.floor(Math.random()* 30) - 5
                updateBackground()
            }
        }

    }

    Component.onCompleted: {
        updateBackground()
    }
}

