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
        delegate: listViewDelegate //获取每个子项
        ScrollBar.vertical: ScrollBar{
            anchors.right: parent.right

        }
        header: listViewHeader
        highlight: Rectangle{ //高亮行颜色 ,改变索引实现
            color:"lightblue"
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0
    }

    Component{
        id:listViewDelegate
        Rectangle{
            id:listViewDelegateItem
            color: "#00000000" //列表行背景颜色
            height: 45 //高度
            width: listView.width
            Shape{ //表格线条
                anchors.fill: parent
                ShapePath{
                    strokeWidth: 0  //宽度为0
                    strokeColor: "#500000000" //表格线条颜色
                    strokeStyle: ShapePath.SolidLine  //设为实线
                    startX: 0
                    startY: 45  //与高度一样
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
                        elide:Qt.ElideMiddle//超出右侧裁剪
                    }
                    Text{
                        text:name
                        //horizontalAlignment: Qt.AlignHCenter //居中
                        Layout.preferredWidth: parent.width*0.4
                        font.family: "微软雅黑"
                        font.pointSize: 13
                        color: "black"
                        elide:Qt.ElideMiddle
                    }
                    Text{
                        text:artist
                        //horizontalAlignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width*0.15
                        font.family: "微软雅黑"
                        font.pointSize: 13
                        color: "black"
                        elide:Qt.ElideMiddle
                    }
                    Text{
                        text:album
                        horizontalAlignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width*0.15
                        font.family: "微软雅黑"
                        font.pointSize: 13
                        color: "black"
                        elide:Qt.ElideMiddle
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
                                    bottomView.saveFavorite({
                                                                id:musicList[index].id,
                                                                name:musicList[index].name,
                                                                artist:musicList[index].artist,
                                                                url:musicList[index].url?musicList[index].url:"",
                                                                album:musicList[index].album,
                                                                type:musicList[index].type?musicList[index].type:"0"
                                                           })
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

            TapHandler{
                cursorShape: Qt.PointingHandCursor
                onTapped: {
                    listView.currentIndex=index //改变选定,实现高亮切换
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
                }
                Text{
                    text:"歌名"
                    Layout.preferredWidth: parent.width*0.4
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight //字数多的省略在右边...
                }
                Text{
                    text:"歌手"
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideMiddle//字数多的省略在中间...
                }
                Text{
                    text:"专辑"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideMiddle
                }
                Text{
                    text:"操作"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: "微软雅黑"
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideMiddle
                }
            }
        }
    }

    Item {  //分页器
        id: pageButton
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
                        loadMore(current*pageSize,index)
                    }
                }
            }
        }
    }

}
