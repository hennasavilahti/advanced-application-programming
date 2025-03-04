import QtQuick 2.12

Item {
    id: speedometerRoot
    width: 400
    height: 400

    // Properties to be set from outside the component
    property real currentSpeed: 0
    property real maxSpeed: 260
    property real initialRotation: 225
    property real warningSpeed: 140 // Speed at which warning appears

    // Background image of the speedometer
    Image {
        id: speedometerBackground
        anchors.fill: parent
        source: "images/gauge.png"
        fillMode: Image.PreserveAspectFit
    }

    // Warning Triangle Container
    Item {
        id: warningContainer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: speedText.bottom
        anchors.topMargin: 5
        width: 30
        height: 30
        visible: currentSpeed >= warningSpeed // Show warning when speed exceeds threshold

        // Warning Triangle Shape
        Canvas {
            id: warningTriangle
            anchors.fill: parent
            opacity: 0.9
            onPaint: {
                var ctx = getContext("2d");
                ctx.beginPath();
                ctx.moveTo(width/2, 0);
                ctx.lineTo(0, height);
                ctx.lineTo(width, height);
                ctx.closePath();

                // Fill with yellow
                ctx.fillStyle = 'yellow';
                ctx.fill();

                // Add black outline
                ctx.strokeStyle = 'black';
                ctx.lineWidth = 2;
                ctx.stroke();
            }
        }

        // Exclamation Mark
        Text {
            anchors.centerIn: parent
            text: "!"
            font.bold: true
            font.pixelSize: 20
            color: "black"
        }
    }

    // Speed Text Display
    Text {
        id: speedText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100

        text: Math.round(currentSpeed)
        font.pixelSize: 35
        font.bold: true
        color: currentSpeed >= warningSpeed ? "red" : "white"
        z: 0
    }

    // Container to keep the needle's bottom fixed at the center
    Item {
        id: needleContainer
        anchors.centerIn: parent
        width: speedometerBackground.width
        height: speedometerBackground.height

        // Needle image
        Image {
            id: speedometerNeedle
            source: "images/needlered.png"
            width: 10
            height: 150

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter

            // Ensure needle is on top
            z: 1

            // Rotate around the bottom point
            transform: Rotation {
                id: needleRotation
                origin.x: speedometerNeedle.width / 2
                origin.y: speedometerNeedle.height
                // Ensure full rotation to 260
                angle: initialRotation + ((currentSpeed / maxSpeed) * 270)
            }
        }
    }
}
