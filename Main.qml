import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 1300
    height: 800
    visible: true
    title: qsTr("音乐播放器")


    ColumnLayout{
        anchors.fill: parent

        //顶部菜单栏
        ToolBar{
            background: Rectangle{
                        color: "#00000000"
                    }
            width: parent.width
            Layout.fillWidth: true
            RowLayout{
                anchors.fill: parent
                Text {
                    id: musicname
                    text: qsTr("网易云音乐")
                    font.family: "微软雅黑"
                    font.pointSize: 28


                }
                ToolButton{
                    icon.source: "qrc:/images/music.png"
                    width: 30
                    height: 30
                }
                ToolButton{
                    icon.source: "qrc:/images/about.png"
                    width: 30
                    height: 30
                }
                ToolButton{
                    icon.source: "qrc:/images/small-screen.png"
                    width: 30
                    height: 30
                }
                Item {
                    Layout.fillWidth: true
                    height: 30
                }
                ToolButton{
                    icon.source: "qrc:/images/minimize-screen.png"
                    width: 30
                    height: 30
                }
                ToolButton{
                    icon.source: "qrc:/images/full-screen.png"
                    width: 30
                    height: 30
                }
                ToolButton{
                    icon.source: "qrc:/images/power.png"
                    width: 30
                    height: 30
                }
            }
        }

        spacing: 0
        //左边框
        Frame{
            Layout.preferredWidth: 200
            Layout.fillHeight: true
            background: Rectangle{
                color: "lightgrey"
            }
            //padding: 0
            spacing: 0
        }

        //底部工具栏
        Rectangle{
            Layout.fillWidth: true
            height: 60
            color: "#00AAAA"

            RowLayout{
                anchors.fill: parent

                Item{
                    Layout.preferredWidth: parent.width/10  //边距
                    Layout.fillWidth: true
                }
                Button{
                    Layout.preferredWidth: 50   //大小
                    icon.source: "qrc:/images/previous.png"
                    icon.height: 30
                    icon.width: 30
                }
                Button{
                    Layout.preferredWidth: 50
                    icon.source: "qrc:/images/stop.png"
                    icon.height: 30
                    icon.width: 30
                }
                Button{
                    Layout.preferredWidth: 50
                    icon.source: "qrc:/images/next.png"
                    icon.height: 30
                    icon.width: 30
                }
                Item{   //进度条
                    Layout.preferredWidth: parent.width/2
                    Layout.fillHeight: true
                    Layout.fillWidth: true


                    Slider{
                        width: parent.width
                        Layout.fillWidth: true
                        height: 30

                    }
                }
                Button{
                    Layout.preferredWidth: 50
                    icon.source: "qrc:/images/favorite.png"
                    icon.height: 30
                    icon.width: 30
                }
                Button{
                    Layout.preferredWidth: 50
                    icon.source: "qrc:/images/repeat.png"
                    icon.height: 30
                    icon.width: 30
                }
                Item{
                    Layout.preferredWidth: parent.width/10
                    Layout.fillWidth: true
                }
            }
        }
    }
}
