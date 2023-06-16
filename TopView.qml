import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

//顶部菜单栏
ToolBar{
    background: Rectangle{
                color: "#00AAAA"
            }
    width: parent.width
    Layout.fillWidth: true
    RowLayout{
        anchors.fill: parent
        Text {
            id: musicName
            text: qsTr("闲暇音乐")
            font.family: "微软雅黑"
            font.pointSize: 28
        }
        MusicToolButton{
            icon.source: "qrc:/images/music.png"
            toolTip: "闲暇音乐"
        }
        MusicToolButton{
            icon.source: "qrc:/images/about.png"
            toolTip: "关于"
            onClicked: {
                aboutPop.open()
               }
        }
        MusicToolButton{
            id:smallwindow
            icon.source: "qrc:/images/small-window.png"
            toolTip: "小窗播放"
            onClicked: {
                setWindowSize(350,600)
                smallwindow.visible = false
                normalwindow.visible = true
            }
        }
        MusicToolButton{
            id:normalwindow
            icon.source: "qrc:/images/exit-small-window.png"
            toolTip: "退出小窗播放"
            visible: false
            onClicked: {
                setWindowSize()
                normalwindow.visible = false
                smallwindow.visible = true
            }
        }
        Item {
            Layout.fillWidth: true
            height: 30
        }
        MusicToolButton{
            icon.source: "qrc:/images/minimize-screen.png"
            toolTip: "最小化"
            onClicked: {
                window.hide()
            }
        }
        MusicToolButton{
            id:maxwindow
            icon.source: "qrc:/images/full-screen.png"
            toolTip: "全屏"
            onClicked: {
                window.visibility = Window.Maximized
                maxwindow.visible = false
                resize.visible = true
            }
        }
        MusicToolButton{
            id:resize
            icon.source: "qrc:/images/small-screen.png"
            toolTip: "退出全屏"
            visible: false
            onClicked: {
                setWindowSize()
                resize.visible = false
                maxwindow.visible = true
            }
        }
        MusicToolButton{
            icon.source: "qrc:/images/power.png"
            toolTip: "退出"
            onClicked: {
                Qt.quit()
            }
        }
    }

    Popup{
        id:aboutPop

        topInset: 0
        leftInset: 0
        rightInset: 0
        bottomInset: 0

        parent: Overlay.overlay
        x:(parent.width-width)/2
        y:(parent.height-height)/2

        width: 250
        height: 230

        background: Rectangle{
            color:"#e9f4ff"
            radius: 5
            border.color: "#2273a7ab"
        }

        contentItem: ColumnLayout{
            width: parent.width
            height: parent.height
            Layout.alignment: Qt.AlignHCenter   //水平居中对齐

            Image{
                Layout.preferredHeight: 60
                source: "qrc:/images/music"
                Layout.fillWidth:true
                fillMode: Image.PreserveAspectFit   //适应尺寸

            }

            Text {
                text: qsTr("作者：田福、邓越心、龚秦")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter  //水平居中对齐
                font.pixelSize: 18
                color: "#8573a7ab"
                font.family: "微软雅黑"
                font.bold: true
            }
            Text {
                text: qsTr("享受音乐的乐趣")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
                color: "#8573a7ab"
                font.family:  "微软雅黑"
                font.bold: true
            }
        }

//        MouseArea {
//            anchors.fill: parent
//            acceptedButtons: Qt.LeftButton
//            hoverEnabled: true
//            property int startX: 0
//            property int startY: 0
//            onPositionChanged: {
//                if (mouse.buttons === Qt.LeftButton) {
//                    aboutPop.x += mouse.x - startX
//                    aboutPop.y += mouse.y - startY
//                }
//            }
//            onPressed: {
//                startX = mouse.x
//                startY = mouse.y
//            }
//            onReleased: {
//                startX = 0
//                startY = 0
//            }
//        }
    }


    function setWindowSize(width=window.w_width,height=window.w_height){
        window.height = height
        window.width = width
        window.x=(Screen.width-window.width)/2
        window.y=(Screen.height-window.height)/2
    }
}

