import QtQuick 2.0
import "common"
import QtQuick.Controls 2.5
Item {
    anchors.fill: parent

    Rectangle {
        id: background
        color: "#707070"
        anchors.fill: parent
    }

    Component.onCompleted: {
        //reset in case someone hits back on seed play
        glc.setProblemType( 0 )
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

    ListModel {
        id: problemTypes
        ListElement { text: "Random" }
        ListElement { text: "Two-Digit X Two Digit" }
        ListElement { text: "Three-Digit X Three-Digit" }
        ListElement { text: "Three Digit X Two Digit" }
    }

    Text {
        id: problemTypeLabel
        font.family: okpupfont.name
        font.pixelSize: 16 * ( parent.height / 600 )
        text: "Problem Type:"
        anchors {
            left: problemModeComboBox.left
            bottom: problemModeComboBox.top
            bottomMargin: 5
        }
        color: "white"
        verticalAlignment: Text.AlignVCenter
    }

    ComboBox {
        id: problemModeComboBox
        model: problemTypes
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: playNow.top
            bottomMargin: 15
        }
        font.family: okpupfont.name
        width: parent.width / 1.5
        height: parent.height / 10

    }

    StylizedButton {
        id: playNow
        anchors.centerIn: parent
        buttonText: "Play Now"
        width: parent.width / 2
        height: parent.height / 8
        onClicked: {
            glc.setProblemType( problemModeComboBox.currentIndex )
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
        width: parent.width / 2
        height: parent.height / 8
        onClicked: {
            glc.setProblemType( problemModeComboBox.currentIndex )
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
        width: parent.width / 2
        height: parent.height / 8
        onClicked: {
            mainLoader.source = "HomeScreen.qml"
        }
    }
}
