import QtQuick
import QtQuick.Controls

Rectangle {
    id: buttonBackground
    height: 50
    width: 170
    color: "darksalmon"
    radius: 10

    // Propertyt
    property string buttonText: "Click me"

    // Signaalit (Eventit, joita komponentti lähettää)
    signal buttonClicked

    Text {
        anchors.centerIn: parent
        text: parent.buttonText
        color: "White"
        font.pixelSize: 24
        font.family: "Arial"
    }

    // Button kuuntelee koko alueellaan hiiren klikkauksia
    MouseArea {
        anchors.fill: parent
        onPressed: {
            buttonBackground.color = "indianred"
            buttonBackground.scale = 0.9
        }

        onReleased: {
            buttonBackground.color = "darksalmon"
            buttonBackground.scale = 1.0
            buttonClicked() // Emit the signal
        }
    }
}
