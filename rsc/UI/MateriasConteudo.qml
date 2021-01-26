import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Prototype 1.0

Page {
    id: page
    property StackView stack: StackView.view

    QMLFile {
        Component.onCompleted: {
            path = stack.data.path

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

            property var contentArray
            Component.onCompleted: {
                if (content) {
                    contentArray = JSON.parse(content)

                    for (var item of contentArray) {
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

                    let i, j = 0
                    let item
                    if (expanded) {
                        for (i = listView.model.count - 1; i >= 0; --i)
                        {
                            item = listView.model.get(i)
                            if (item.type === "topic") continue

                            for (j = 0; j < contentArray.length; ++j) {
                                if (contentArray[j].index === item.index) {
                                    listView.model.remove(i)
                                }
                            }
                        }
                    } else {
                        for (i = contentArray.length - 1; i >= 0; --i)
                        {
                            for (j = 0; j < listView.model.count; ++j) {
                                item = listView.model.get(j)
                                if (item.type === "subtopic") continue

                                if (item.index === index) {
                                    break
                                }
                            }

                            listView.model.insert(j + 1, contentArray[i])
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
