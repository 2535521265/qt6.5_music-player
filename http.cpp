#include "http.h"

//网络连接
Http::Http(QObject *parent)
    : QObject{parent}
{
    manager=new QNetworkAccessManager(this);
    connect(manager,SIGNAL(finished(QNetworkReply*)),this,SLOT(replyFinished(QNetworkReply*)));
}

void Http::replyFinished(QNetworkReply *reply)
{
    emit replySignal(reply->readAll());

}

void Http::connet(QString url)
{
    QNetworkRequest request;
    request.setUrl(base_url+url);
    manager->get(request);

}
