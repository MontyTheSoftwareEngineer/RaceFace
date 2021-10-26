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
        text: qsTr("Results")
    }

    TextEdit {
        id: seedDisplayText
        readOnly: true
        anchors {
            top: titleFont.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        font.family: okpupfont.name
        font.pixelSize: 40 * ( parent.height / 600)
        color: "white"
        text: "Seed: " + glc.gameSeed
        selectByMouse: true
    }

    Text {
        id: timeDisplayText
        anchors {
            top: seedDisplayText.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        font.family: okpupfont.name
        font.pixelSize: 40 * ( parent.height / 600)
        color: "white"
        text: "Time: " + gameTimer.gameTimeDisplay
    }

    Text {
        id: securityCheck
        anchors {
            top: timeDisplayText.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        font.family: okpupfont.name
        font.pixelSize: 40 * ( parent.height / 600)
        color: "white"
        text: "New Seed: " + ( gameSecurity.securityBit ? "False" : "True" )
    }

    Text {
        id: pauseCheck
        anchors {
            top: securityCheck.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        font.family: okpupfont.name
        font.pixelSize: 40 * ( parent.height / 600)
        color: "white"
        text: "No Pause: " + ( gameSecurity.pauseBit ? "False" : "True" )
    }


    StylizedButton {
        id: newGameButton
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 20
        }

        buttonText: "Done"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            gameTimer.clearTimer()
            mainLoader.source = "HomeScreen.qml"
        }
    }

    CheckBox {
        id: showProblemsRadioButton
        anchors {
            left: parent.left
            top: parent.top
            margins: 15
        }
        onCheckedChanged: {
            if ( checked )
            {

            }
        }
        checked: false
    }

    Text {
        id: showProblemsLabel
        font.family: okpupfont.name
        font.pixelSize: 18 * ( parent.height / 600 )
        text: "Show Questions"
        anchors {
            left: showProblemsRadioButton.left
            verticalCenter: showProblemsRadioButton.verticalCenter
            leftMargin: 50
        }
        color: "white"
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: problemsList
        visible: showProblemsRadioButton.checked
        font.family: okpupfont.name
        font.pixelSize: 18 * ( parent.height / 600 )
        text: glc.getQuestionList()
        anchors {
            left: showProblemsLabel.left
            top: showProblemsLabel.bottom
            topMargin: 10
        }
        color: "white"
        verticalAlignment: Text.AlignVCenter
    }
}
