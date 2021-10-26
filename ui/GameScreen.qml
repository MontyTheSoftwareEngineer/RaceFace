import QtQuick 2.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.3
import "common"
import OKPUP 1.0

Item {
    anchors.fill: parent
    property string answerInput: ""

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
        gameSecurity.setPauseBit( false )
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

    Connections {
        target: gameTimer
        onGamePaused: {
            gameSecurity.setPauseBit( true )
            pauseScreen.visible = true
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
//        Keys.onPressed: {
//            console.log( event.key )
//            if ( glc.inputNormal )
//                return;
//            if ( (event.key >= 48) && ( event.key <= 39 ) ) {
//                if ( answerInput == "" ) {
//                    answerInput = event.text
//                }
//                else {
//                    answerInput = event.text + answerInput
//                    answerInputTextField.text = answerInput
//                    event.accepted = true
//                }
//            }
//        }
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

    StylizedButton {
        id: pauseButton
        anchors {
            top: problemDisplay.bottom
            topMargin: 40
            right: answerInputTextField.left
            rightMargin: 20
        }

        buttonImageSource: "qrc:/ui/assets/pause.png"
        hasImage: true
        width: height
        radius: height / 2
        height: parent.height / 10
        onClicked: {
            gameTimer.stopTimer()
            pauseScreen.visible = true
        }
    }

    StylizedButton {
        id: restartButton
        anchors {
            top: problemDisplay.bottom
            topMargin: 40
            right: pauseButton.left
            rightMargin: 20
        }

        buttonImageSource: "qrc:/ui/assets/refresh.png"
        hasImage: true
        width: height
        radius: height / 2
        height: parent.height / 10
        onClicked: {
            answerInputTextField.text = ""
            gameSecurity.setPauseBit( false )
            glc.useCurrentSeed()
            glc.initList()
            gameSecurity.addSeed( glc.gameSeed )
            gameTimer.clearTimer()
        }
    }

    Rectangle{
        id: pauseScreen
        anchors.fill: parent
        color: "#707070"
        visible: false
    }

    Text {
        id: pauseText
        visible: pauseScreen.visible
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        font.family: okpupfont.name
        font.pixelSize: 60 * ( parent.height / 600)
        color: "white"
        text: qsTr("Game Paused")
    }

    MouseArea {
        anchors.fill: pauseScreen
        enabled: pauseScreen.visible
    }

    StylizedButton {
        id: resumeButton
        anchors.centerIn: parent
        visible: pauseScreen.visible
        buttonText: "Resume"
        width: parent.width / 3
        height: parent.height / 8
        onClicked: {
            gameSecurity.setPauseBit( true );
            gameTimer.startTimer();
            pauseScreen.visible = false
        }
    }

}
