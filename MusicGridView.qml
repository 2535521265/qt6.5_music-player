import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml 2.12

//推荐歌单
Item {
    property alias list: gridRepeator.model
    Grid{
        id:gridLayout
        anchors.fill: parent
        columns: 5  //列数
        Repeater{
            id:gridRepeator
            Frame{
                padding: 10
                width: parent.width*0.2
                height: parent.width*0.2+30
                background: Rectangle{
                    color: "#00000000"
                }
                clip: true
                MusicRoundImage{
                    id:img
                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.coverImgUrl
                }

                Text{
                    anchors{
                        top:img.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: modelData.name
                    font{
                        family: "微软雅黑"
                    }
                    height: 30
                    elide: Qt.ElideMiddle
                    width: parent.width
                    verticalAlignment: Text.AlignVCenter  //字体上下居中
                    horizontalAlignment: Text.AlignHCenter  //字体左右居中

                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true  //鼠标悬浮效果
                    cursorShape: Qt.PointingHandCursor //鼠标显示手型
                    onEntered: {
                        background.color = "#50000000"//鼠标移入变色
                    }
                    onExited: {
                        background.color = "#00000000"
                    }
                    onClicked: {
                        var item = gridRepeator.model[index]
                        homeView.showPlayList(item.id,"1000")
                        }

                    }
                }
            }
    }
}
