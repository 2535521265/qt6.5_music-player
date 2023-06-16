import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Layouts 1.15
import QtQuick.Shapes
Frame{

    property var musicList:[]
    property int all:0
    property int pageSize:60
    property int current:0
    signal loadMore(int offset,int current)

    onMusicListChanged: {
        listViewModel.clear()
        listViewModel.append(musicList)
    }

    Layout.fillHeight: true
    Layout.fillWidth: true
    clip: true
    padding:0
    background: Rectangle{
        color: "#00000000"
    }

    ListView{
        id:listView
        anchors.fill: parent
        anchors.bottomMargin: 70

        model:ListModel{
            id:listViewModel
        }
        delegate: listViewDelegate
        ScrollBar.vertical: ScrollBar{
            anchors.right: parent.right

        }
        header: listViewHeader
        highlight: Rectangle{
            color:"#f0f0f0"
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0
    }

    Component{
        id:listViewDelegate
        Rectangle{
            id:listViewDelegateItem
//            color: "#aaa"
            height: 45
            width: listView.width
            Shape{
                anchors.fill: parent
                ShapePath{
                    strokeWidth: 0
                    strokeColor: "#500000000"
                    strokeStyle: ShapePath.SolidLine
                    startX: 0
                    startY: 45
                    PathLine{
                        x:0
                        y:45
                    }
                    PathLine{
                        x:1100
                        y:45
                    }
                }
            }

             MouseArea{
                RowLayout{
                width: parent.width
                height: parent.height
                spacing: 15
                x:5
                Text{
                    text:index+1+pageSize*current
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.05
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "black"
                    elide:Qt.ElideMiddle//倾斜
                }
                Text{
                    text:name
//                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.4
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "black"
                    elide:Qt.ElideMiddle//倾斜
                }
                Text{
                    text:artist
//                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "black"
                    elide:Qt.ElideMiddle//倾斜
                }
                Text{
                    text:album
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "black"
                    elide:Qt.ElideMiddle//倾斜
                }
                Item{
                    Layout.preferredWidth: parent.width*0.15
                    RowLayout{
                        anchors.centerIn: parent
                        MusicIconButton{
                            iconSource: "qrc:/images/pause"
                            iconHeight: 16
                            iconWidth: 16
                            toolTip: "播放"
                            onClicked: {
                                bottomView.current=-1
                                bottomView.playList=musicList                               
                                bottomView.current=index
                            }
                        }
                        MusicIconButton{
                            iconSource: "qrc:/images/favorite"
                            iconHeight: 16
                            iconWidth: 16
                            toolTip: "喜欢"
                            onClicked: {

                            }
                        }
                        MusicIconButton{
                            iconSource: "qrc:/images/clear"
                            iconHeight: 16
                            iconWidth: 16
                            toolTip: "删除"
                            onClicked: {

                            }
                        }
                    }
                }
            }
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    color="#f0f0f0"
                }
                onExited: {
                    color="#00000000"
                }
                onClicked: {
                    listViewDelegateItem.listView.view.currentIndex=index
                }
            }

        }

    }
    Component{
        id:listViewHeader
        Rectangle{
            color: "#00AAAA"
            height: 45
            width: listView.width
            RowLayout{
                width: parent.width
                height: parent.height
                spacing: 15
                x:5
                Text{
                    text:"序号"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.05
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight//倾斜
                }
                Text{
                    text:"歌名"
//                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.4
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideMiddle//倾斜
                }
                Text{
                    text:"歌手"
//                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideMiddle//倾斜
                }
                Text{
                    text:"专辑"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideMiddle//倾斜
                }
                Text{
                    text:"操作"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight//倾斜
                }
            }
        }
    }

    Item {
        id: pageButton
        visible: musicList.length!==0
        width: parent.width
        anchors.top: listView.bottom
        height: 40
        anchors.topMargin: 10
        ButtonGroup{
            buttons: buttons.children
        }
        RowLayout{
            id:buttons
            anchors.centerIn: parent
            Repeater{
                id:repeater
                model: all/pageSize>9?9:all/pageSize
                Button{
                    Text{
                        anchors.centerIn: parent
                        text:modelData+1
                        font.family: "微软雅黑"
                        font.pointSize: 14
                        color:checked?"#497563":"black"
                    }
                    background: Rectangle{
                        implicitHeight: 30
                        implicitWidth: 30
                        color:checked?"#e2f0f8":"#20e9f4ff"
                        radius: 3
                    }
                    checkable: true
                    checked: modelData===current
                    onClicked: {
                        if(current===index)return
//                        current=index
                        loadMore(current*pageSize,index)
                    }
                }
            }
        }
    }

}
