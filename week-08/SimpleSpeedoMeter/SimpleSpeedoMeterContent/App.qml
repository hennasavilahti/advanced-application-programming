import QtQuick
import SimpleSpeedoMeter
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    id: root
    width: 600
    height: 600

    Rectangle {
        anchors.fill: parent
        color: "black"
        gradient: Gradient {
            GradientStop {
                position: 0.0;
                color: "#303030";
            }
            GradientStop {
                position: 0.75;
                color: "black";
            }
        }

        Speedometer {
            id: speedometer
            anchors.centerIn: parent

            // Initial speed setup
            currentSpeed: 0
            maxSpeed: 260
            initialRotation: 225
            warningSpeed: 140
        }

        // Control buttons layout
        RowLayout {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            // Gas Button
            Button {
                text: "Gas"
                onPressed: {
                    // Accelerate: Increase speed
                    accelerationTimer.start()
                }
                onReleased: {
                    accelerationTimer.stop()
                }
            }

            // Brake Button
            Button {
                text: "Brake"
                onPressed: {
                    // Decelerate: Decrease speed
                    brakeTimer.start()
                }
                onReleased: {
                    brakeTimer.stop()
                }
            }
        }

        // Acceleration Timer
        Timer {
            id: accelerationTimer
            interval: 10
            repeat: true
            onTriggered: {
                // Increase speed, but don't exceed max speed
                speedometer.currentSpeed = Math.min(speedometer.currentSpeed + 1, speedometer.maxSpeed)
            }
        }

        // Brake Timer
        Timer {
            id: brakeTimer
            interval: 10
            repeat: true
            onTriggered: {
                // Decrease speed, but don't go below 0
                speedometer.currentSpeed = Math.max(speedometer.currentSpeed - 1, 0)
            }
        }
    }

}

