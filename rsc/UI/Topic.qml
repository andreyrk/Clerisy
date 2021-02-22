import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "Utilities"

Page {
    id: page

    UrlRequest {
        id: file

        onStart: {
            url = Globals.currentSubject.path
        }

        onFinish: {
            Globals.currentSubject = JSON.parse(response)

            var index = 0
            for (var item of Globals.currentSubject.content)
            {
                listView.model.append({
                    index: index++
                })
            }

            page.title = Globals.currentSubject.title
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        model: ListModel {}
        delegate: Column {
            width: page.width
            height: listParent.height + (listChildren.visible ? listChildren.height : 0)

            Rectangle {
                id: listParent
                width: page.width
                height: 40
                color: "#FFFFFF"

                Border {
                    leftWidth: 0
                    rightWidth: 0
                    topWidth: Style.borderWidth
                    bottomWidth: 0

                    color: Style.borderColor
                }

                Item {
                    width: page.width
                    height: 40

                    Item {
                        width: 40
                        height: 40

                        Image {
                            id: icon
                            anchors.centerIn: parent

                            source: listChildren.visible ? Globals.icon_ExpandLess : Globals.icon_ExpandMore
                            sourceSize.width: 24
                            sourceSize.height: 24
                        }
                    }

                    Text {
                        rightPadding: 5
                        x: 40
                        width: page.width - 40
                        height: 40

                        text: Globals.currentSubject.content[index].title
                        font {
                            pixelSize: 14
                        }
                        maximumLineCount: 1
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            if (listChildren.visible) {
                                listChildren.visible = false
                            } else {
                                listChildren.visible = true
                            }
                        }
                    }
                }
            }

            Column {
                id: listChildren
                visible: false

                Repeater {
                    model: Globals.currentSubject.content[index].content

                    Item {
                        y: 40
                        width: page.width
                        height: 40

                        Text {
                            rightPadding: 5
                            x: 40
                            width: page.width - 40
                            height: 40

                            text: modelData.title
                            font {
                                pixelSize: 14
                            }
                            maximumLineCount: 1
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Globals.currentSubtopic = modelData
                                Globals.app.load(Globals.pageSubtopic)
                            }
                        }
                    }
                }
            }
        }
    }
}
