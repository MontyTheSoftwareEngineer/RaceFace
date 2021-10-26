import QtQuick 2.12

Rectangle {
    property string buttonText: "buttonText"
    property string buttonColor: "#A5CD50"
    property string buttonPressedColor: "#759139"
    property string buttonTextColor: "white"
    property bool hasImage: false
    property string buttonImageSource: ""

    FontLoader {
        id: customFont
        source: "qrc:/ui/assets/Highman.ttf"
    }

    signal clicked()
    signal pressed()
    signal released()


    id: stylizedButton
    color: buttonColor
    radius: 10

    Text {
        visible: !hasImage
        font.pixelSize: 26 * ( parent.height / 75)
        color: buttonTextColor
        anchors.centerIn: parent
        font.family: customFont.name
        text: buttonText
    }
    Image {
        id: buttonImage
        source: buttonImageSource
        anchors.centerIn: parent
        visible: hasImage
        width: parent.width * .5
        fillMode: Image.PreserveAspectFit
        height: width
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.color = buttonPressedColor
            stylizedButton.pressed()
        }
        onReleased: {
            parent.color = buttonColor
            stylizedButton.released()
        }
        onClicked: {
            stylizedButton.clicked()
        }
    }
}
