import QtQuick
import QtQuick.Controls

Rectangle {
    id: calendar
    width: 600
    height: 600
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#ffffff";
        }
        GradientStop {
            position: 1.00;
            color: "#f9b7b7";
        }
    }

    property int selectedDay: 0 // Koko calendar -komponentille näkyvä muuttuja

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Joulukuu"
            font.pixelSize: 50
            font.family: "Arial"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Grid {
            columns: 7
            spacing: 10

            Repeater { // Sukua list viewille. Toistetaan jotain komponenttia.
                model: 31
                Rectangle {
                    width: 70
                    height: 70
                    radius: 10
                    color: "white"
                    border.color: "grey"

                    Text {
                        anchors.centerIn: parent
                        text: (index + 1).toString()
                        font.pixelSize: 20
                        font.family: "Arial"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            dayView.openDayView()
                            selectedDay = (index + 1)
                        }
                    }
                }
            }
        }
    }

    Rectangle { // Välikomponentti, häivyttää kalenterin taustalle
        id: overlay
        anchors.fill: parent
        color: "black"
        opacity: 0.8
        visible: dayView.visible // Näkyvissä, kun dayView näkyvissä
    }

    Rectangle {
        id: dayView
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.centerIn: parent
        visible: false
        radius: 10
        border.color: "grey"
        opacity: 0


        Text {
            id: day
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 80
            text: "Päivän " + selectedDay + " ohjelma"
            font.pixelSize: 35
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            text: "Sulje"
            font.pixelSize: 15
            onClicked: dayView.closeDayView();
        }

        // Lisätään kalenterin toiminnallisuus Javascript -funktioina
        function openDayView() {
            visible = true;
            opacity = 1;
            scale = 1;
            opacityAnimation.start()
            scaleAnimation.start()
        }

        function closeDayView() {
            visible = false;
            opacity = 0;
            scale = 0;
        }

        // Animaatioesimerkki PropertyAnimation määrittelee, miten toimitaan kun property muuttuu (esim. opacity)
        PropertyAnimation {
            id: opacityAnimation
            target: dayView // Mihin komponenttiin animaatio liittyy
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }

        PropertyAnimation {
            id: scaleAnimation
            target: dayView // Mihin komponenttiin animaatio liittyy
            property: "scale"
            from: 0
            to: 1
            duration: 200
        }

    }

}















