#include <QApplication>
#include <QQmlApplicationEngine>
#include "qmlfile.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    qmlRegisterType<QMLFile>("Prototype", 1, 0, "QMLFile");

    QQmlApplicationEngine engine;
    engine.load("qrc:/UI/App.qml");

    return app.exec();
}
