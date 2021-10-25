import QtQuick 2.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.3
import "common"
import OKPUP 1.0

Item {
    anchors.fill: parent

    function checkAnswer() {
        if( glc.checkAnswer( answerInputTextField.text ) ) {
            problemDisplay.color = "white"
            answerInputTextField.text = ""
            glc.nextQuestion()
        }
        else {
            problemDisplay.color = "red"
            wrongTimer.start()
        }
    }

    Component.onCompleted: {
        gameTimer.startTimer()
        answerInputTextField.forceActiveFocus()
    }

    Connections {
        target: glc
        onGameFinished: {
            gameTimer.stopTimer()
            mainLoader.source = "ResultsScreen.qml"
        }
    }

    Timer {
        id: wrongTimer
        interval: 1000
        onTriggered: problemDisplay.color = "white"
    }

    Rectangle {
        id: background
        color: "#707070"
        anchors.fill: parent
    }

    Text {
        id: gameTimeDisplay
        anchors {
            top: parent.top
            right: parent.right
            margins: 5
        }
        font.family: okpupfont.name
        font.pixelSize: 18 * ( parent.height / 600 )
        color: "white"
        text: gameTimer.gameTimeDisplay
    }

    Text {
        id: progressDisplay
        anchors {
            top: parent.top
            left: parent.left
            margins: 5
        }
        font.family: okpupfont.name
        font.pixelSize: 18 * ( parent.height / 600 )
        color: "white"
        text: glc.progressDisplay
    }

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    Text {
        id: problemDisplay
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 40
        }
        font.family: okpupfont.name
        font.pixelSize: 60 * ( parent.height / 600)
        color: "white"
        text: glc.problemDisplay
    }

    TextField {
        id: answerInputTextField
        width: parent.width / 3
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: checkButton.verticalCenter
        }
        inputMethodHints: "ImhDigitsOnly"
        horizontalAlignment: Text.AlignHCenter
        onAccepted: {
            checkAnswer()
        }
        font.pixelSize: 32 * ( parent.height / 600 )
        font.family: okpupfont.name
    }

    StylizedButton {
        id: checkButton
        anchors {
            top: problemDisplay.bottom
            topMargin: 40
            left: answerInputTextField.right
            leftMargin: 10
        }

        buttonText: "Check"
        width: parent.width / 6
        height: parent.height / 10
        onClicked: {
            checkAnswer()
        }
    }

}