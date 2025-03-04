import QtQuick
import SimpleCalendar

Window {
    id:mainWindow
    width: 600
    height: 600

    visible: true
    title: "CalendarDisplay"

    Calendar {
        anchors.centerIn: parent
    }

}

