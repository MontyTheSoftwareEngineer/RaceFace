import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.1
import OKPUP 1.0

Window {
    visible: true
    width: 800
    height: 600
    title: qsTr("RaceFace")

    FontLoader { id: customFont; source: "qrc:/ui/assets/MyOlivin-Regular.ttf" }
    FontLoader { id: okpupfont; source: "qrc:/ui/assets/Highman.ttf" }

    GameLogicController
    {
        id: glc
    }

    GameTimer {
        id: gameTimer
    }

    GameSecurity {
        id: gameSecurity
    }

    Rectangle {
        id: background
        color: "#707070"
        anchors.fill: parent
    }

    Loader {
        id: mainLoader
        anchors.fill: parent
        source: "ui/HomeScreen.qml"
    }

    Text {
        id: okpuplogo
        anchors {
            bottom: parent.bottom
            right: parent.right
            margins: 10
        }
        font.family: okpupfont.name
        font.pixelSize: 28 * ( parent.height / 600 )
        color: "white"
        text: "OKPUP"
    }

    InputPanel {
        id: virtualKeyboard
        height: 300 * ( parent.height / 600 )
        visible: active
        anchors.left: mainLoader.left
        anchors.right: mainLoader.right
        anchors.bottom: mainLoader.bottom
        externalLanguageSwitchEnabled: true
    }
}
