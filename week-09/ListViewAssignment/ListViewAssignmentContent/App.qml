import QtQuick
import ListViewAssignment
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 500
    height: 500
    visible: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Tekstikenttä ja button row-layoutissa
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: newItemField
                Layout.fillWidth: true
                font.pixelSize: 16
                placeholderText: "Add new item..."
                onAccepted: addButton.clicked()
                background: Rectangle {
                    border.color: "lavender"
                    border.width: newItemField.activeFocus ? 2 : 1
                    radius: 4
                }
            }

            Button {
                id: addButton
                text: "Add"
                font.pixelSize: 16
                onClicked: {
                    if (newItemField.text.trim() !== ""){
                        itemModel.append({ "name": newItemField.text.trim() })
                        newItemField.text = ""
                    }
                }
            }
        }

        // ListView-container
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            // ListView näyttämään tekstit
            ListView {
                id: listView
                anchors.fill: parent
                clip: true
                model: ListModel {
                    id: itemModel
                }

                delegate: Rectangle {
                    width: listView.width
                    height: 40
                    color: index % 2 === 0 ? "#f0f0f0" : "#e0e0e0"

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        text: name
                        font.pixelSize: 14
                    }
                }

                // Header
                header: Rectangle {
                    width: listView.width
                    height: 30
                    color: "lavender"
                    radius: 5

                    Text {
                        anchors.centerIn: parent
                        text: "Items"
                        font.pixelSize: 16
                    }
                }
            }

            // Näkymän reunus
            Rectangle {
                anchors.fill: listView
                color: "transparent"
                border.width: 3
                border.color: "lavender"
                radius: 5
                z: 2
            }
        }

        // Näytetään listan koko alareunassa
        Text {
            text: "Item count: " + itemModel.count
            Layout.alignment: Qt.AlignRight
            font.pixelSize: 14
            color: "grey"
        }
    }
}
