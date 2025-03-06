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
    property color currentColor: "black"

    property string city: "Haetaan säätietoja..."
    property string weather: "..."
    property string icon: ""
    property double temperature: 0
    property double windspeed: 0
    property string apiKey: "YOUR_API_KEY_HERE"

    // Funktio, joka vaihtaa taustan väriä lämpötilan mukaan
    function updateBackground() {
        if (temperature < 0) {
            gradientStopColor = "deepskyblue"
        } else if (temperature >= 20) {
            gradientStopColor = "indianred"
        } else  if (temperature > 10){
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
            text: city
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
                source: "https://openweathermap.org/img/wn/"+ icon + "@4x.png"
            }


            Column {
                id: weatherDetailsColum
                anchors.verticalCenter: image.verticalCenter
                spacing: 20

                Text {
                    id: weatherText
                    text: weather
                    font.pixelSize: 35
                    font.family: "Arial"
                }

                Text {
                    id: temperatureText
                    text: temperature + " °C"
                    font.pixelSize: 35
                    font.family: "Arial"
                }

                Text {
                    id: windSpeedText
                    text: windspeed + " m/s"
                    font.pixelSize: 35
                    font.family: "Arial"
                }
            }
        }
    }

    // Kutsutaan funktiota, kun komponentti on näytöllä (lifecycle event)
    Component.onCompleted: {
        fetchWeatherData()
        updateBackground()

    }

    // Javascript -funktio, joka hakee säätiedot OpenWeatherMap -palvelimelta
    function fetchWeatherData() {
        const url = "https://api.openweathermap.org/data/2.5/weather?q=tampere&units=metric&appid=" + apiKey
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("GET", url); // Luodaan pyyntö get requestille

        // Toteutetaan callbackit valmistuneelle resurssille
        httpRequest.onreadystatechange = function() {
            // Tässä käsitellään itse JSON -data
            if( httpRequest.readyState === XMLHttpRequest.DONE ) { // Request on valmis
                if ( httpRequest.status === 200) { // Request ok, pitäisi olla data
                    // Päivitetään city, temperature ja windspeed
                    const response = JSON.parse( httpRequest.responseText ); // Response on nyt meidän JSON -objekti
                    city = response.name;
                    weather = response.weather[0].description
                    icon = response.weather[0].icon
                    temperature = response.main.temp;
                    windspeed = response.wind.speed;
                    updateBackground();
                }
                else {
                    // Error fetching data (ilmoita käyttöliittymälle) httpRequest.status kertoo virheen
                    city = "Virhe latauksessa..."
                }
            }
        }
        httpRequest.send(); // Lähetetään pyyntö
    }
}

