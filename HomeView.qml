import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml


RowLayout{


    spacing: 0 //取消元素间的间隔

    property var qmlList: [
        {icon:"recommend-white",value:"推荐内容",qml:"DetailRecommendPageView"},
        {icon:"cloud-white",value:"搜索音乐",qml:"DetailSearchPageView"},
        {icon:"local-white",value:"本地音乐",qml:"DetailLocalPageView"},
        {icon:"history-white",value:"播放历史",qml:"DetailHistoryPageView"},
        {icon:"favorite-big-white",value:"我喜欢的",qml:"DetailFavoritePageView"},
        //{icon:"favorite-big-white",value:"专辑歌单",qml:"DetailPlayListPageView"}
    ]


    //左边框
    Frame{

        Layout.preferredWidth: 200
        Layout.fillHeight: true
        background: Rectangle{ //左边框背景颜色
            color: "#AA00AAAA"
        }

        padding: 0 //取消元素内间隔


        ColumnLayout{
            anchors.fill: parent

            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: 180
                MusicRoundImage{
                    anchors.centerIn:parent  //放在中心
                    height: 130
                    width:130
                    borderRadius: 100
                }
            }

            ListView{
                id:menuView
                height: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: true
                model:ListModel{
                    id:menuViewModel
                }
                delegate:menuViewDelegate
                highlight:Rectangle{ //首模块默认颜色
                    color: "#aa73a7db"
                }
                highlightMoveDuration: 500    //鼠标移动高亮持续时间
                highlightResizeDuration: 0  //高亮持续时间
            }
        }

        Component{
            id:menuViewDelegate
            Rectangle{
                id:menuViewDelegateItem
                height: 50
                width: 200
                color: "#AA00AAAA"//初始默认颜色
                RowLayout{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    spacing:15
                    Item{ //占位 使字体居中
                        width: 30
                    }

                    Image{//图标大小
                        source: "qrc:/images/"+icon
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                    }

                    Text{//左侧字体
                        text:value
                        Layout.fillWidth: true
                        height:50
                        font.family: "微软雅黑"
                        font.pointSize: 12
                        color: "#ffffff"
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {//鼠标移入ui的颜色
                        color="#aa73a7ab"
                    }
                    onExited: {//鼠标移出ui的颜色
                        color="#AA00AAAA"
                    }
                    onClicked:{//实现鼠标点击切换不同ui
                        repeater.itemAt(menuViewDelegateItem.ListView.view.currentIndex).visible =false
                        menuViewDelegateItem.ListView.view.currentIndex = index
                        var loader = repeater.itemAt(menuViewDelegateItem.ListView.view.currentIndex)
                        loader.visible=true
                        loader.source = qmlList[index].qml+".qml"
                    }
                }
            }
        }

        Component.onCompleted: {
            menuViewModel.append(qmlList)
            var loader = repeater.itemAt(0)
            loader.visible=true
            loader.source = qmlList[0].qml+".qml"
        }
    }

    Repeater{
        id:repeater
        model: qmlList.length
        Loader{
            visible: false
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

}

