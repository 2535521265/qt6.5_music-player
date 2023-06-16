import QtQuick
import QtQuick.Controls

Frame{
    property int current: 0
    property var bannerList: []

    background: Rectangle{
        color: "#00000000"
    }

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
            bannerTimer.stop()
        }
        onExited: {
            bannerTimer.start()
        }
    }

    MusicRoundImage{    //左侧轮播图
        id:leftImage
        width:parent.width*0.6
        height: parent.height*0.8
        anchors{
            left: parent.left
            bottom: parent.bottom
            bottomMargin: 20
        }

        imgSrc: getLeftImgSrc()

        onImgSrcChanged: {
            leftImageAnim.start()
        }

        NumberAnimation{
            id:leftImageAnim
            target: leftImage
            property: "scale"
            from: 0.8
            to:1.0
            duration: 200
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if(bannerList.length>0)
                    current = current==0?bannerList.length-1:current-1
            }
        }
    }

    MusicRoundImage{    //中间轮播图
        id:centerImage
        width:parent.width*0.6  //宽度
        height: parent.height   //高度
        z:2     //显示在上层
        anchors.centerIn: parent    //中间
        imgSrc: getCenterImgSrc()   //获取图

        onImgSrcChanged: {
            centerImageAnim.start()
        }
        NumberAnimation{
            id:centerImageAnim
            target: centerImage
            property: "scale"
            from: 0.8
            to:1.0
            duration: 200
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }

    MusicRoundImage{    //右侧轮播图
        id:rightImage
        width:parent.width*0.6
        height: parent.height*0.8
        anchors{
            right: parent.right
            bottom: parent.bottom
            bottomMargin: 20
        }
        imgSrc: getRightImgSrc()

        onImgSrcChanged: {
            rightImageAnim.start()
        }

        NumberAnimation{
            id:rightImageAnim
            target: rightImage
            property: "scale"
            from: 0.8
            to:1.0
            duration: 200
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if(bannerList.length>0)
                    current = current==bannerList.length-1?0:current+1
            }
        }
    }

    PageIndicator{
            anchors{
                top:centerImage.bottom
                horizontalCenter: parent.horizontalCenter
            }
            count: bannerList.length
            interactive: true
            onCurrentIndexChanged: {
                current = currentIndex
            }
            delegate: Rectangle{
                width:20
                height: 5
                radius: 5
                color: current===index?"balck":"gray"
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        bannerTimer.stop()
                        current = index
                    }
                    onExited: {
                        bannerTimer.start()
                    }
                }
            }

        }

        Timer{
            id:bannerTimer
            running: true
            interval: 5000
            repeat: true
            onTriggered: {
                if(bannerList.length>0)
                    current = current==bannerList.length-1?0:current+1
            }
        }

    function getLeftImgSrc(){   //获取左侧轮播图
        return bannerList.length?bannerList[(current-1+bannerList.length)%bannerList.length].imageUrl:""
    }
    function getCenterImgSrc(){     //获取中间轮播图
        return bannerList.length?bannerList[current].imageUrl:""
    }
    function getRightImgSrc(){      //获取右侧轮播图
        return bannerList.length?bannerList[(current+1+bannerList.length)%bannerList.length].imageUrl:""
    }
}

