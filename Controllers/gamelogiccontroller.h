#ifndef GAMELOGICCONTROLLER_H
#define GAMELOGICCONTROLLER_H

#include <QObject>

class GameLogicController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString gameSeed READ gameSeed WRITE setGameSeed NOTIFY gameSeedChanged)
    Q_PROPERTY(QString problemDisplay READ problemDisplay NOTIFY problemDisplayChanged)
    Q_PROPERTY(QString progressDisplay READ progressDisplay WRITE setProgressDisplay NOTIFY progressDisplayChanged)
    Q_PROPERTY(bool inputNormal READ inputNormal WRITE setInputNormal NOTIFY inputNormalChanged)
public:
    explicit GameLogicController(QObject *parent = nullptr);
    Q_INVOKABLE void useCurrentSeed();

    QString gameSeed(){ return m_seed; }
    QString progressDisplay(){ return m_progressDisplay; }

    Q_INVOKABLE void initList();
    QString problemDisplay();
    Q_INVOKABLE bool checkAnswer( const QString & answer );
    Q_INVOKABLE void nextQuestion();
    Q_INVOKABLE QString getQuestionList();
    Q_INVOKABLE void setProblemType( const int & index );

    bool inputNormal() { return m_inputNormal; }

public slots:
    Q_INVOKABLE void setGameSeed( const QString & seed );
    Q_INVOKABLE void setProblemDisplay( const QString & text );
    Q_INVOKABLE void setProgressDisplay( const QString & text );
    Q_INVOKABLE void setInputNormal( const bool & val );

signals:
    void gameSeedChanged();
    void problemDisplayChanged();
    void gameFinished();
    void progressDisplayChanged();
    void inputNormalChanged();

private:
    bool m_inputNormal;
    QString m_seed;
    QString m_progressDisplay;
    QString m_problemDisplay;
    QList< QPair< int, int > > m_gameProblemList;
    int m_currentProblemCount;
    int m_problemType;
};

#endif // GAMELOGICCONTROLLER_H
