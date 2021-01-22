#ifndef QMLFILE_H
#define QMLFILE_H

#include "qqml.h"
#include <QFile>
#include <QObject>

class QMLFile : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString path MEMBER m_path NOTIFY pathChanged)
    QString m_path;

    QByteArray data;
public:
    Q_INVOKABLE void load(const QString &path)
    {
        m_path = path;

        if(QFile file(m_path); file.open(QIODevice::ReadOnly))
        {
            data = file.readAll();
        }
    }

    Q_INVOKABLE QString asString()
    {
        if (data.isEmpty()) load(m_path);

        return QString(data);
    }
signals:
    void pathChanged(const QString& newPath);
};

#endif // QMLFILE_H
