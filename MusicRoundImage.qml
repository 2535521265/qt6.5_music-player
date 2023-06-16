import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

//左边框的音乐圆形封面
Item {
    property string imgSrc: "qrc:/images/player.jpg"
    property int borderRadius: 5

    Image{
        id:image
        anchors.centerIn: parent
        source:imgSrc
        smooth: true
        visible: false
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop  //设置填充模式为保持纵横比并裁剪多余部分
        antialiasing: true  //开启抗锯齿
    }

    Rectangle{
        id:mask
        color: "black"
        anchors.fill: parent
        radius: borderRadius
        visible: false
        smooth: true
        antialiasing: true
    }

    OpacityMask{
        anchors.fill:image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }
}

