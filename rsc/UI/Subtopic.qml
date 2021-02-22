import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "Utilities"

Page {
    id: page

    Component.onCompleted: {
        title = Globals.currentSubject.title

        for (let video of Globals.currentSubtopic.videos) {
            grid.model.append({
                video: video
            })
        }
    }

    footer: TabBar
    {
        id: tabBar
        width: parent.width
        contentHeight: 40

        anchors.bottom: parent.bottom

        TabButton {
            text: "Aulas"

            contentItem: Text {
                width: parent.width
                height: parent.height
                text: parent.text
                font: parent.font
                opacity: parent.checked ? 1.0 : 0.33
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                anchors.fill: parent
                color: "#E0E0E0"
            }
        }

        TabButton {
            text: "Exercícios"

            contentItem: Text {
                width: parent.width
                height: parent.height
                text: parent.text
                font: parent.font
                opacity: parent.checked ? 1.0 : 0.33
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                anchors.fill: parent
                color: "#E0E0E0"
            }
        }

        background: Rectangle {
            color: "#E0E0E0"

            Border {
                leftWidth: 0
                rightWidth: 0
                topWidth: Style.borderWidth
                bottomWidth: 0

                color: Style.borderColor
            }
        }
    }

    StackLayout {
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        DynamicGrid {
            id: grid
            anchors.fill: parent

            keepAspectRatio: true
            preferredCellWidth: 480
            preferredCellHeight: 270
            horizontalSpacing: 10
            verticalSpacing: 10
            margin: 10

            delegate: Rectangle {
                width: grid.cellWidth - grid.horizontalSpacing
                height: grid.cellHeight - grid.verticalSpacing

                border.width: Style.borderWidth
                border.color: Style.borderColor

                Image {
                    id: thumbnail
                    anchors.centerIn: parent

                    width: parent.width - 2
                    height: parent.height - 2

                    fillMode: Image.PreserveAspectCrop
                    source: "https://img.youtube.com/vi/" + video + "/0.jpg"

                    RowLayout {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10

                        height: 40
                        spacing: 10

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            border.width: Style.borderWidth
                            border.color: Style.borderColor
                            color: "#FFFFFF"

                            Label {
                                id: title
                                padding: 10
                                width: parent.width
                                height: parent.height

                                font {
                                    pixelSize: 13
                                    weight: Font.DemiBold
                                    capitalization: Font.AllUppercase
                                }

                                maximumLineCount: 1
                                elide: Text.ElideRight

                                horizontalAlignment: Text.AlignHLeft
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Rectangle {
                            Layout.preferredWidth: parent.height
                            Layout.preferredHeight: parent.height

                            border.width: Style.borderWidth
                            border.color: Style.borderColor
                            color: "#FFFFFF"

                            Image {
                                anchors.centerIn: parent

                                source: Globals.icon_PlayArrow
                                sourceSize.width: 24
                                sourceSize.height: 24
                            }
                        }
                    }

                    MouseArea {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        height: 60

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            Qt.openUrlExternally("https://youtube.com/watch?v=" + video)
                        }
                    }
                }

                UrlRequest {
                    property string endpoint: "https://www.youtube.com/oembed?format=json&url=https://www.youtube.com/watch?v="

                    onStart: {
                        url = endpoint + video
                    }

                    onFinish: {
                        let data = JSON.parse(response)

                        if (data) {
                            title.text = data.title
                        }
                    }
                }
            }
            model: ListModel {}
        }

        Item {
            id: tabExercicios
            anchors.fill: parent
        }
    }
}
