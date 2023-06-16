import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
        MusicIconButton{
            Layout.preferredWidth: 50   //大小
            icon.source: "qrc:/images/previous.png"
            toolTip: "上一首"
        }
        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: "qrc:/images/stop.png"
            toolTip: "暂停/播放"
        }
        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: "qrc:/images/next.png"
            toolTip: "下一首"
        }
        Item{   //进度条
            Layout.preferredWidth: parent.width/2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20


            Slider{
                id:slider
                width: parent.width
                Layout.fillWidth: true
                height: 30
                background: Rectangle{
                    x:slider.leftPadding
                    y:slider.topPadding+(slider.availableHeight-height)/2
                    width: slider.availableWidth
                    height: 4
                    radius: 2
                    color: "#e9f4ff"
                    Rectangle{
                        width: slider.visualPosition*parent.width
                        height: parent.height
                        color: "red"
                        radius: 2
                    }
                }

                handle: Rectangle{
                    x:slider.leftPadding+(slider.availableWidth-width)*slider.visualPosition
                    y:slider.topPadding+(slider.availableHeight-height)/2
                    width: 15
                    height: 15
                    radius: 10
                    color: "#f0f0f0"
                    border.color: "red"
                    border.width: 0.5
                }
            }

            Text {
                id:timeTxet
                text: qsTr("00:00/.5:30")
                anchors.right: slider.right
                anchors.bottom: slider.top
                font.family: "微软雅黑"
                color: "white"
            }
        }
        MusicIconButton{
                    Layout.preferredWidth: 50
                    text: "词"//找到图后补充上去就删除这行
                    //icon.source: "qrc:/images/repeat.png"
                    toolTip: "歌词"
                }
        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: "qrc:/images/favorite.png"
            toolTip: "我喜欢"
        }
        MusicIconButton{
            Layout.preferredWidth: 50
            icon.source: "qrc:/images/repeat.png"
            toolTip: "重复播放"
        }
        Item{
            Layout.preferredWidth: parent.width/10
            Layout.fillWidth: true
        }
    }
}
