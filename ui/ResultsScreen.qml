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

    Text {
        id: modeLabel
        anchors {
            top: titleFont.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        font.family: okpupfont.name
        font.pixelSize: 40 * ( parent.height / 600)
        color: "white"
        text: "Mode: " + glc.getModeType()
    }

    TextEdit {
        id: seedDisplayText
        readOnly: true
        anchors {
            top: modeLabel.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
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

    Rectangle {
        id: showQuestionsBG
        color: "#707070"
        anchors.fill: parent
        visible: false
    }

    Text {
        id: problemsList
        visible: showQuestionsBG.visible
        font.family: okpupfont.name
        font.pixelSize: 24 * ( parent.height / 600 )
        text: glc.getQuestionList()
        anchors {
            top: parent.top
            topMargin: 40
            horizontalCenter: parent.horizontalCenter
        }
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    StylizedButton {
            id: showQuestionsButton
            anchors {
                bottom: doneButton.top
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 20
            }

            buttonText: {
                if ( showQuestionsBG.visible )
                    "Back"
                else
                    "Show Questions"
            }

            width: parent.width / 2
            height: parent.height / 10
            onClicked: {
                if ( showQuestionsBG.visible )
                    showQuestionsBG.visible = false
                else
                    showQuestionsBG.visible = true
            }
        }


        StylizedButton {
            id: doneButton
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 40
            }

            buttonText: "Done"
            width: parent.width / 2
            height: parent.height / 8
            onClicked: {
                gameTimer.clearTimer()
                mainLoader.source = "HomeScreen.qml"
            }
        }
}
