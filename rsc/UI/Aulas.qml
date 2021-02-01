import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "Utilities"

Page {
    id: page
    property StackView stack: StackView.view

    Component.onCompleted: {
        title = stack.data.title

        for (let video of stack.data.videos) {
            grid.model.append({
                video: video
            })
        }
    }

    TabBar {
        id: bar
        width: parent.width
        anchors.bottom: parent.bottom

        TabButton {
            text: "Aulas"
        }

        TabButton {
            text: "Exercícios"
        }
    }

    StackLayout {
        width: parent.width
        height: parent.height - bar.height
        currentIndex: bar.currentIndex

        DynamicGrid {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true

            keepAspectRatio: true

            preferredCellWidth: 480
            preferredCellHeight: 270

            leftMargin: 10
            topMargin: 10
            horizontalSpacing: 10
            verticalSpacing: 10

            delegate: Rectangle {
                width: grid.cellWidth - grid.horizontalSpacing
                height: grid.cellHeight - grid.verticalSpacing

                border.width: 1
                border.color: "#E0E0E0"

                Image {
                    id: thumbnail
                    anchors.centerIn: parent

                    width: parent.width
                    height: parent.height

                    fillMode: Image.PreserveAspectCrop
                    source: "https://img.youtube.com/vi/" + video + "/0.jpg"

                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5

                        height: 36

                        border.width: 1
                        border.color: "#E0E0E0"

                        Label {
                            id: title
                            padding: 10

                            width: parent.width - parent.height + padding
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

                        Item {
                            anchors.right: parent.right
                            height: parent.height
                            width: parent.height

                            Image {
                                anchors.centerIn: parent

                                source: "qrc:/Icon/Play-Arrow.svg"
                                sourceSize.width: 24
                                sourceSize.height: 24
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Qt.openUrlExternally("http://youtube.com/watch?v=" + video)
                            }
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
                        title.text = data.title
                    }
                }
            }
            model: ListModel {}
        }

        Item {
            id: tabExercicios
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
