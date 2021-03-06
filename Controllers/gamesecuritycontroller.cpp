#include "gamesecuritycontroller.h"
#include <QDebug>

GameSecurityController::GameSecurityController(QObject *parent)
    : QObject(parent)
    , m_securityBit( false )
    , m_pauseBit( false )
{
    m_settings = new QSettings( "OKPUP", "QuickMaths" );
}

GameSecurityController::~GameSecurityController()
{
    m_settings->deleteLater();
}

void GameSecurityController::addSeed(const QString &seed)
{
    m_settings->setValue( seed, "1" );
}

bool GameSecurityController::hasSeed(const QString &seed)
{
    return ( m_settings->allKeys().contains(seed) );
}

void GameSecurityController::setSecurityBit(const bool &bit)
{
    if ( m_securityBit != bit )
    {
        m_securityBit = bit;
        emit securityBitChanged();
    }
}

void GameSecurityController::setPauseBit(const bool &bit)
{
    if ( m_pauseBit != bit )
    {
        m_pauseBit = bit;
        emit pauseBitChanged();
    }
}
