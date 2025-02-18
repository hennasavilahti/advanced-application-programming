import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    width: 170
    height: 400
    color: "black"
    radius: 20

    property bool trafficLightsBlinking: false
    property bool trafficLightsOn: true

    Column {
        anchors.centerIn: parent
        spacing: 8

        Rectangle {
            id: redLight
            width: 120
            height: 120
            radius: 60
            color: "red"
            opacity: 0.1
        }

        Rectangle {
            id: yellowLight
            width: 120
            height: 120
            radius: 60
            color: "yellow"
            opacity: 0.1
        }

        Rectangle {
            id: greenLight
            width: 120
            height: 120
            radius: 60
            color: "green"
            opacity: 0.1
        }

        Timer {
            id: lightTimer
            interval: 1000
            repeat: true
            running: trafficLightsOn // Voidaan käynnistää nappulasta (lightTimer.running = true)

            onRunningChanged: {
                if (running === false) {
                    yellowLight.opacity = 0.1
                    greenLight.opacity = 0.1
                    redLight.opacity = 0.1
                }
            }

            onTriggered: {
                // Logiikka, jos liikennevalot päällä
                if (!trafficLightsBlinking) {
                    if ( redLight.opacity === 1.0 ) { // Punainen on päällä -> vaihdetaan keltaiselle
                        redLight.opacity = 0.1
                        yellowLight.opacity = 1.0
                        // Voidaan halutessa muuttaa intervallia
                    }
                    else if ( yellowLight.opacity === 1.0 ) {
                        yellowLight.opacity = 0.1
                        greenLight.opacity = 1.0
                    }
                    else  {
                        greenLight.opacity = 0.1
                        redLight.opacity = 1.0
                    }
                } else { // Logiikka, jos liikennevalot pois päältä
                    if (yellowLight.opacity === 0.1) {
                        yellowLight.opacity = 1.0
                        greenLight.opacity = 0.1
                        redLight.opacity = 0.1
                    } else {
                        yellowLight.opacity = 0.1
                        greenLight.opacity = 0.1
                        redLight.opacity = 0.1
                    }
                }
            }
        }

    }

}
