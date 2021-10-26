import QtQuick 2.0
import "common"
import QtQuick.Controls 2.2

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

    RadioButton {
        id: leftToRight
        anchors {
            bottom: playNow.top
            left: playNow.left
            bottomMargin: 15
        }

        checked: true
        onCheckedChanged: {
            if ( checked )
            {
                rightToleft.checked = false
                glc.setInputNormal( true )
            }
        }
    }

    Text {
        id: leftToRightLabel
        font.family: okpupfont.name
        font.pixelSize: 18 * ( parent.height / 600 )
        text: "Left to Right"
        anchors {
            left: leftToRight.left
            verticalCenter: leftToRight.verticalCenter
            leftMargin: 50
        }
        color: "white"
        verticalAlignment: Text.AlignVCenter
    }

    RadioButton {
        id: rightToLeft
        anchors {
            left: leftToRightLabel.right
            verticalCenter: leftToRight.verticalCenter
            leftMargin: 20
        }
        onCheckedChanged: {
            if ( checked )
            {
                leftToRight.checked = false
                glc.setInputNormal( false )
            }
        }
    }

    Text {
        id: rightToLeftLabel
        font.family: okpupfont.name
        font.pixelSize: 18 * ( parent.height / 600 )
        text: "Right to Left"
        anchors {
            left: rightToLeft.left
            verticalCenter: leftToRight.verticalCenter
            leftMargin: 50
        }
        color: "white"
        verticalAlignment: Text.AlignVCenter
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
