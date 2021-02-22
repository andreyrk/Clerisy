#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray(1, 1));

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load("qrc:/UI/App.qml");

    return app.exec();
}
