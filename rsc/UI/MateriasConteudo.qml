import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Prototype 1.0

Page {
    id: page
    property StackView stack: StackView.view

    QMLFile {
        path: stack.data.path

        Component.onCompleted: {
            var obj = JSON.parse(getString())
            var index = 0

            for (var item of obj.content)
            {
                item.index = index++
                item.content = JSON.stringify(item.content)

                listView.model.append(item)
            }

            page.title = obj.title
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        add: Transition {
            NumberAnimation { properties: "opacity"; from: 0.2; to: 1.0; duration: 250}
        }

        model: ListModel { }

        delegate: Rectangle {
            implicitWidth: listView.width
            implicitHeight: 40

            property bool expanded: false
            onExpandedChanged: refresh()

            property var contentObject
            Component.onCompleted: {
                if (content) {
                    contentObject = JSON.parse(content)

                    for (var item of contentObject) {
                        item.index = index
                    }
                }

                refresh()
            }

            function refresh() {
                if (type === "topic") {
                    if (expanded) {
                        icon.source = "qrc:/Icon/Expand-Less.svg"
                    } else {
                        icon.source = "qrc:/Icon/Expand-More.svg"
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (type !== "topic") return

                    var i = 0
                    var listItem
                    if (expanded) {
                        for (i = listView.model.count - 1; i >= 0; --i) {
                            listItem = listView.model.get(i)

                            if (listItem.type === "topic") continue

                            for (var item of contentObject) {
                                if (item.index === listItem.index) {
                                    listView.model.remove(i)
                                }
                            }
                        }
                    } else {
                        for (let item of contentObject.reverse())
                        {
                            for (i = 0; i < listView.model.count; ++i) {
                                listItem = listView.model.get(i)

                                if (listItem.type === "subtopic") continue

                                if (listItem.index === index) {
                                    break
                                }
                            }

                            listView.model.insert(i + 1, item)
                        }
                    }

                    expanded = !expanded
                }
            }

            RowLayout {
                Item {
                    width: 40
                    height: 40

                    Image {
                        id: icon
                        anchors.centerIn: parent

                        source: ""
                        sourceSize.width: 24
                        sourceSize.height: 24
                    }
                }

                Text {
                    id: text

                    text: title
                    font {
                        bold: false
                        pixelSize: 14
                        weight: Font.Thin
                    }
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
