/*2021051615038gongqin
 *歌词唱片详情
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

Item {
    property alias lyrics: lyricsView.lyrics
     property alias current: lyricsView.current
    Layout.fillHeight: true
    Layout.fillWidth: true
    RowLayout{
        anchors.fill: parent
        Frame{

            Layout.preferredWidth: parent.width*0.4
            Layout.fillHeight: true
            Text{
                id:name
                text: bottomView.musicName
                anchors{
                    bottom:artist.top
                    bottomMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family: "微软雅黑"
                    pointSize: 16
                }
            }
            Text{
                id:artist
                text: bottomView.musicArtist
                anchors{
                    bottom:cover.top
                    bottomMargin: 50
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family: "微软雅黑"
                    pointSize: 14
                }
            }

            MusicBorderImage{
                id:cover
                width: parent.width*0.6
                height: width
                borderRadius: width
                anchors.centerIn: parent
                imgSrc: bottomView.musicCover
                isRotating:bottomView.playingState===1//歌曲播放绑定唱片转动

            }
        }
        Frame{
            Layout.preferredWidth: parent.width*0.6
             Layout.fillHeight: true

             MusicLyricsView{
                 id:lyricsView
                 anchors.fill: parent
             }

        }
    }

}
