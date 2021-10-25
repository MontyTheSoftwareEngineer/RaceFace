#ifndef GAMESECURITYCONTROLLER_H
#define GAMESECURITYCONTROLLER_H

#include <QObject>
#include <QSettings>

class GameSecurityController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool securityBit READ securityBit WRITE setSecurityBit NOTIFY securityBitChanged)
public:
    explicit GameSecurityController(QObject *parent = nullptr);
    ~GameSecurityController();
    Q_INVOKABLE void addSeed( const QString & seed );
    Q_INVOKABLE bool hasSeed( const QString & seed );

    bool securityBit() { return m_securityBit; }
    Q_INVOKABLE void setSecurityBit( const bool & bit );


signals:
    void securityBitChanged();

private:
    QSettings * m_settings;
    bool m_securityBit;
};

#endif // GAMESECURITYCONTROLLER_H
