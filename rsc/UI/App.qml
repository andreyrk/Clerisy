import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: app
    width: 960
    height: 640
    visible: true
    title: "Prototype"

    property string pageMaterias: "qrc:/UI/Materias.qml"
    property string pageOpcoes: "qrc:/UI/Opcoes.qml"

    header: ToolBar {
        id: header
        height: 40

        Item {
            width: header.height
            height: header.height

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                    } else {
                        drawer.open()
                    }
                }
            }

            Image {
                anchors.centerIn: parent

                source: stackView.depth > 1 ? "qrc:/Icon/Chevron-Left.svg" : "qrc:/Icon/Menu.svg"
                sourceSize.width: 24
                sourceSize.height: 24
            }
        }

        Label {
            text: stackView.currentItem ? stackView.currentItem.title : ""
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: implicitWidth * 8/5
        height: app.height

        ColumnLayout {
            spacing: 0
            width: drawer.width - 1

            ItemDelegate {
                text: "Matérias"
                Layout.fillWidth: true
                Layout.preferredHeight: header.height

                onClicked: {
                    drawer.close()
                    stackView.goTo(pageMaterias)
                }
            }

            ItemDelegate {
                text: "Opções"
                Layout.fillWidth: true
                Layout.preferredHeight: header.height

                onClicked: {
                    drawer.close()
                    stackView.goTo(pageOpcoes)
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        property var data: ({})

        Component.onCompleted: {
            goTo(pageMaterias)
        }

        function goTo(page) {
            clear();
            push(page)
        }
    }
}
