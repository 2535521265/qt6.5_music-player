/*
 * 2021051205101tianfu
 * 2021051615042dengyuexin
 * */
import QtQuick
import QtQuick.Controls
import QtQml

//新歌推荐
Item{
    property alias list: gridRepeater.model

    Grid{
        id:gridLayout
        anchors.fill:parent
        columns: 3
        Repeater{
            id:gridRepeater
            Frame{
                padding: 5
                width: parent.width*0.333
                height: parent.width*0.1
                background: Rectangle{
                    id:background
                    color: "#00000000"
                }

                clip: true

                MusicRoundImage{
                    id:img
                    width: parent.width*0.25
                    height: parent.width*0.25
                    imgSrc: modelData.album.picUrl
                }

                Text{  //歌曲名称
                    id:name
                    anchors{
                        left: img.right
                        verticalCenter: parent.verticalCenter
                        bottomMargin: 10
                        leftMargin: 5
                    }
                    text:modelData.album.name
                    font.family: "微软雅黑"
                    font.pointSize: 11
                    height:30
                    width: parent.width*0.72
                    elide: Qt.ElideRight
                }
                Text{  //歌手名称
                    anchors{
                        left: img.right
                        top: name.bottom
                        leftMargin: 5
                    }
                    text:modelData.artists[0].name
                    font.family: "微软雅黑"
                    height:30
                    width: parent.width*0.72
                    elide: Qt.ElideRight
                }
                TapHandler{
                   cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
