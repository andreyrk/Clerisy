import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: page
    title: "Matérias"
    property StackView stack: StackView.view
    property string pageConteudo: "qrc:/UI/MateriasConteudo.qml"

    GridView {
        id: grid
        anchors.fill: parent

        leftMargin: 10
        topMargin: 10

        property int minimumCellWidth: 180
        property int minimumCellHeight: 90
        cellWidth: minimumCellWidth
        cellHeight: minimumCellHeight

        boundsBehavior: Flickable.StopAtBounds

        onWidthChanged: {
            let bounds = {
                width: width - leftMargin - rightMargin,
                height: height - topMargin - bottomMargin
            }

            if (minimumCellWidth * count < bounds.width) {
                cellWidth = minimumCellWidth
            } else if (minimumCellWidth * 1.5 <= bounds.width) {
                if (bounds.width % minimumCellWidth >= 0) {
                    cellWidth = Math.floor(bounds.width / Math.floor(bounds.width / minimumCellWidth))
                } else {
                    cellWidth = bounds.width
                }
            } else if (minimumCellWidth * 1.5 > bounds.width) {
                cellWidth = bounds.width
            }
        }

        model: ListModel {
            ListElement {
                title: "Matemática Básica"
                path: "qrc:/Data/Matematica-Basica.json"
            }

            ListElement {
                title: "Matemática"
                path: "qrc:/Data/Matematica.json"
            }

            ListElement {
                title: "Física"
                path: "qrc:/Data/Fisica.json"
            }

            ListElement {
                title: "Química"
                path: "qrc:/Data/Quimica.json"
            }

            ListElement {
                title: "Biologia"
                path: "qrc:/Data/Biologia.json"
            }

            ListElement {
                title: "Português"
                path: "qrc:/Data/Portugues.json"
            }

            ListElement {
                title: "Redação"
                path: "qrc:/Data/Redacao.json"
            }

            ListElement {
                title: "Literatura"
                path: "qrc:/Data/Literatura.json"
            }

            ListElement {
                title: "Inglês"
                path: "qrc:/Data/Ingles.json"
            }

            ListElement {
                title: "Espanhol"
                path: "qrc:/Data/Espanhol.json"
            }

            ListElement {
                title: "Geografia"
                path: "qrc:/Data/Geografia.json"
            }

            ListElement {
                title: "História"
                path: "qrc:/Data/Historia.json"
            }

            ListElement {
                title: "Sociologia"
                path: "qrc:/Data/Sociologia.json"
            }

            ListElement {
                title: "Filosofia"
                path: "qrc:/Data/Filosofia.json"
            }

            ListElement {
                title: "Artes"
                path: "qrc:/Data/Artes.json"
            }

            ListElement {
                title: "Atualidades"
                path: "qrc:/Data/Atualidades.json"
            }
        }

        delegate: Rectangle {
            width: grid.cellWidth - 10
            height: grid.cellHeight - 10

            radius: 4
            border.width: 1
            border.color: "#E0E0E0"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    stack.data = {
                        "title": title,
                        "path": path
                    }

                    stack.load(pageConteudo)
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                Rectangle {
                    color: "#E0E0E0"
                    Layout.fillWidth: true
                    Layout.minimumHeight: 1
                    Layout.maximumHeight: 1
                    Layout.alignment: Qt.AlignBottom
                }

                Label {
                    id: label
                    padding: 6

                    text: title
                    font {
                        bold: false
                        pixelSize: 14
                        weight: Font.Thin
                    }
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignBottom
                }
            }
        }
    }
}
