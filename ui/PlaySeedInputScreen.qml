import QtQuick 2.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.3
import "common"

Item {
    anchors.fill: parent

    Rectangle {
        id: background
        color: "#707070"
        anchors.fill: parent
    }

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    TextField {
        id: seedInputTextField
        width: parent.width / 2
        anchors {
            bottom: playButton.top
            bottomMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        inputMethodHints: "ImhDigitsOnly"
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 40 * ( parent.height / 600 )
        font.family: okpupfont.name
    }

    Text {
        id: titleFont
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        font.family: okpupfont.name
        font.pixelSize: 32 * ( parent.height / 600)
        color: "white"
        text: qsTr("Enter Seed")
    }

    StylizedButton {
        id: playButton
        anchors.centerIn: parent
        buttonText: "Play"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            gameSecurity.setSecurityBit( gameSecurity.hasSeed( seedInputTextField.text ) )
            glc.setGameSeed( seedInputTextField.text )
            glc.initList()
            gameSecurity.addSeed( seedInputTextField.text )
            mainLoader.source = "GameScreen.qml"
        }
    }

    StylizedButton {
        id: backButton
        anchors {
            top: playButton.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 25
        }

        buttonText: "Back"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            mainLoader.source = "GameSelectScreen.qml"
        }
    }
}
