import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: page
    title: "Matérias"
    property string pageConteudo: "qrc:/UI/MateriasConteudo.qml"
    property StackView stackView: StackView.view

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
                titulo: "Matemática"
                materia: "qrc:/Data/Matematica-Basica.qml"
            }

            ListElement {
                titulo: "Matemática Básica"
                materia: "qrc:/Data/Matematica-Basica.qml"
            }

            ListElement {
                titulo: ""
                materia: "qrc:/Data/Matematica-Basica.qml"
            }

            ListElement {
                titulo: ""
                materia: "qrc:/Data/Matematica-Basica.qml"
            }

            ListElement {
                titulo: ""
                materia: "qrc:/Data/Matematica-Basica.qml"
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
                    stackView.data = {
                        "materia": materia
                    }

                    stackView.goTo(pageConteudo)
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

                    text: titulo
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
