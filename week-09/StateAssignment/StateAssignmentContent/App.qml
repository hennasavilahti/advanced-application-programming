import QtQuick
import StateAssignment
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    width: 500
    height: 500
    visible: true

    RowLayout {
        anchors.centerIn: parent
        spacing: 100

        Rectangle {
            id: onRectangle
            width: 100
            height: 100
            color: "grey"
            radius: 5
            state: "inactive"

            Text {
                text: "ON"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 20
                font.bold: true
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges {
                        target: onRectangle
                        color: "green"
                        width: 150
                        height: 150
                    }
                }
            ]

            transitions: [
                Transition {
                    PropertyAnimation {
                        target: onRectangle
                        duration: 1000
                    }
                }
            ]

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    onRectangle.state = (onRectangle.state === "inactive" ? "active" : "inactive");
                }
            }
        }

        Rectangle {
            id: offRectangle
            width: 100
            height: 100
            color: "grey"
            radius: 5
            state: "inactive"

            Text {
                text: "OFF"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 20
                font.bold: true
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges {
                        target: offRectangle
                        color: "darkred"
                        width: 150
                        height: 150
                    }
                }
            ]

            transitions: [
                Transition {
                    PropertyAnimation {
                        target: offRectangle
                        duration: 1000
                    }
                }
            ]

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    offRectangle.state = (offRectangle.state === "inactive" ? "active" : "inactive");
                }
            }
        }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 60
        text: "POWER"
        font.pixelSize: 15
        font.bold: true

        onClicked: {
            onRectangle.state = (onRectangle.state === "inactive" ? "active" : "inactive");
            offRectangle.state = (offRectangle.state === "inactive" ? "active" : "inactive");
        }
    }
}
