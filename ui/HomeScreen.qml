import QtQuick 2.0
import "common"
Item {
    anchors.fill: parent

    Rectangle {
        id: background
        color: "#707070"
        anchors.fill: parent
    }

    Text {
        id: titleFont
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        font.family: okpupfont.name
        font.pixelSize: 60 * ( parent.height / 600)
        color: "white"
        text: qsTr("RaceFace")
    }

    StylizedButton {
        id: playButton
        anchors.centerIn: parent
        buttonText: "Play"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            mainLoader.source = "GameSelectScreen.qml"
        }
    }

    StylizedButton {
        id: quitButton
        anchors {
            top: playButton.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 25
        }

        buttonText: "Quit"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            Qt.quit()
        }
    }
}
