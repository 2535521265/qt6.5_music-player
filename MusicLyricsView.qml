/*2021051615038gongqin
 *歌词
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

Rectangle {
    property alias lyrics: list.model
    property alias current: list.currentIndex
    id:lyricsView
    Layout.preferredHeight: parent.height*0.8
    Layout.alignment: Qt.AlignHCenter
    clip: true
    ListView{
        id:list
        anchors.fill: parent
        model:["暂无歌词",".","..."]
        delegate: listDelegate
        highlight: Rectangle{
            color:"#2073a7db"
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0
        currentIndex: 0
        preferredHighlightBegin: parent.height/2-50
        preferredHighlightEnd: parent.height/2
        highlightRangeMode: ListView.StrictlyEnforceRange
    }
    Component{
        id:listDelegate
        Item {
            id: delegateItem
            width: 660
            height: 50
            Text{
                text: modelData
                anchors.centerIn: parent
                color: index===list.currentIndex?"black":"#505050"
                font{
                    family: "微软雅黑"
                    pointSize: 12
                }
            }
            states:State{
                when:delegateItem.ListView.isCurrentItem
                PropertyChanges {
                    target: delegateItem
                    scale:1.2
                }
            }
            MouseArea{
                anchors.fill: parent
                onCanceled: list.currentIndex=index
                onClicked: {

                }
            }
        }
    }
}
