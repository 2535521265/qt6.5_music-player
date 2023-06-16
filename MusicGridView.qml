import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml 2.12

Item {
    property alias list: gridRepeator.model
    Grid{
        id:gridLayout
        anchors.fill: parent
        columns: 5
        Repeater{
            id:gridRepeator
            Frame{
                padding: 5
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
                }
            }
        }
    }
}
