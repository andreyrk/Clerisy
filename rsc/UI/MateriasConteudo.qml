import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Prototype 1.0

Page {
    id: page
    property StackView stackView: StackView.view

    QMLFile {
        path: ":/Data/Matematica-Basica.json"

        Component.onCompleted: {
            let obj = JSON.parse(asString())

            for (let i of obj.content) {
                listView.model.append({
                    title: i.title,
                    type: i.type
                })

                for (let j of i.content) {
                    listView.model.append({
                        title: j.title,
                        type: j.type,
                        urls: j.urls,
                        frequency: j.frequency
                    })
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        model: ListModel { }

        delegate: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 40

            Component.onCompleted: {
                if (type === "subtopic") {
                    text.leftPadding = 40
                }
            }

            Text {
                id: text
                anchors.fill: parent
                padding: 8

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
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
