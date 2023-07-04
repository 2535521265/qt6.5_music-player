/*
 * 2021051205101tianfu
 * 2021051615038gongqin
 * 2021051615042dengyuexin
 * */
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

//转盘图片

Rectangle {
    property string imgSrc: "qrc:/images/player.jpg"
    property int borderRadius: 5
    property bool isRotating: false
     property real rotationAngel: 0.0
    radius:borderRadius
    //渐变显示
    gradient:Gradient{
        GradientStop{
            position: 0.0
            color: "#101010"
        }
        GradientStop{
            position: 0.5
            color: "#a0a0a0"
        }
        GradientStop{
            position: 1.0
            color: "#505050"
        }
    }


    Image{
        id:image
        anchors.centerIn: parent
        source:imgSrc
        smooth: true
        visible: false
        width: parent.width*0.9
        height: parent.height*0.9
        fillMode: Image.PreserveAspectCrop  //设置填充模式为保持纵横比并裁剪多余部分
        antialiasing: true  //开启抗锯齿
    }

    //蒙版
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
        id:maskImage
        anchors.fill:image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }
    NumberAnimation {
        property:"rotation"
        loops: Animation.Infinite
        target: maskImage
        from:rotationAngel
        to:360+rotationAngel
        running: isRotating
        duration: 100000
        onStopped: {
            rotationAngel=maskImage.rotation

        }
    }
}


