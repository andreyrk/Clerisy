#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray(1, 1));

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load("qrc:/UI/App.qml");

    return app.exec();
}
