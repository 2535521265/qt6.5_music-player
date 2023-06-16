#ifndef HTTP_H
#define HTTP_H

//网络连接
#include <QObject>
#include<QNetworkAccessManager>
#include<QNetworkReply>

class Http : public QObject
{
    Q_OBJECT
public:
    explicit Http(QObject *parent = nullptr);
    Q_INVOKABLE void replyFinished(QNetworkReply* reply);
    Q_INVOKABLE void connet(QString url);

signals:
    void replySignal(QString reply);

private:
    QNetworkAccessManager *manager;
    QString base_url="http://localhost:3000/";

};

#endif // HTTP_H
