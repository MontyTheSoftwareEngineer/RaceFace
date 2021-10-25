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
        text: qsTr("Select Mode")
    }

    StylizedButton {
        id: playNow
        anchors.centerIn: parent
        buttonText: "Play Now"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            glc.useCurrentSeed();
            glc.initList()
            gameSecurity.setSecurityBit( false )
            gameSecurity.addSeed( glc.gameSeed )
            mainLoader.source = "GameScreen.qml"
        }
    }

    StylizedButton {
        id: playSeed
        anchors {
            top: playNow.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 25
        }

        buttonText: "Play Seed"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            mainLoader.source = "PlaySeedInputScreen.qml"
        }
    }

    StylizedButton {
        id: backButton
        anchors {
            top: playSeed.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 25
        }

        buttonText: "Back"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            mainLoader.source = "HomeScreen.qml"
        }
    }
}
