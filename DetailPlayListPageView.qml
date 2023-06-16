import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

ColumnLayout{
    Rectangle{

            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x:10
                verticalAlignment: Text.AlignBottom
                text: qsTr("歌单")
                font.family: "微软雅黑"
                font.pointSize: 25
            }
        }

        RowLayout{
            height: 200
            width: parent.width
            MusicRoundImage{
                id:playListCover
                width: 180
                height: 180
                imgSrc: "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"
            }

            Item{
                Layout.fillWidth: true
                height: parent.height

                Text{
                    id:playListDesc
                    text:"https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpghttps://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpghttps://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpghttps://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"
                    width: parent.width
                    anchors.centerIn: parent
                    wrapMode: Text.WrapAnywhere
                    font.family: window.mFONT_FAMILY
                    font.pointSize: 14
                    maximumLineCount: 4
                    elide: Text.ElideRight
                    lineHeight: 1.5
                }
            }
        }

        MusicListView{
            id:playListListView
        }

    }



















