TARGET = meego-lines
CONFIG += link_pkgconfig
CONFIG += meegotouch
QT += declarative
QT += svg

DEFINES += HARMATTAN
LIBS += -lqjson

CONFIG(debug, debug|release) {
  DEFINES += LINES_DEBUG=1
  QMAKE_CXXFLAGS_DEBUG *= -O0
  QMAKE_CFLAGS_DEBUG *= -O0
}

# Silence the "mangling of 'va_list' has changed in GCC 4.4" warning
QMAKE_CXXFLAGS *= -Wno-unused-parameter -Wno-psabi

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable
DEFINES += HARMATTAN_BOOSTER

SOURCES += \
    src/LinesBalls.cpp \
    src/LinesDir.cpp \
    src/LinesPrefs.cpp \
    src/LinesScores.cpp \
    src/LinesSet.cpp \
    src/LinesState.cpp \
    src/main.cpp \
    src/MeegoLines.cpp \
    src/QuickLinesColors.cpp \
    src/QuickLinesGame.cpp \
    src/QuickLinesModel.cpp \
    src/QuickNextBallsModel.cpp \
    src/SystemState.cpp

HEADERS += \
    src/LinesBalls.h \
    src/LinesDebug.h \
    src/LinesScores.h \
    src/LinesSet.h \
    src/LinesState.h \
    src/LinesPrefs.h \
    src/LinesTypes.h \
    src/MeegoLines.h \
    src/QuickLines.h \
    src/QuickLinesColors.h \
    src/QuickLinesGame.h \
    src/QuickLinesModel.h \
    src/QuickNextBallsModel.h \
    src/SystemState.h

OTHER_FILES += \
    meego/* \
    qml/meego/*.qml \
    qml/common/*.qml \
    qml/common/images/*.svg \
    qml/common/styles/ball/*.svg \
    qml/common/styles/shape/*.svg \
    qml/meego/images/*.svg \
    rpm/harbour-lines.changes \
    rpm/harbour-lines.spec \
    translations/*.ts \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

# Translations
TR_DIR = $$_PRO_FILE_PWD_/translations
qtPrepareTool(LRELEASE,lrelease)

TR_EN_QM = meego-lines.qm
TR_EN_TS = $$TR_DIR/harbour-lines.ts
lrelease_en.input = TR_EN_TS
lrelease_en.output = $$TR_DIR/$$TR_EN_QM
lrelease_en.commands = $$LRELEASE $$TR_EN_TS -qm $$TR_DIR/$$TR_EN_QM
lrelease_en.CONFIG = no_link
lrelease_en.variable_out = PRE_TARGETDEPS
QMAKE_EXTRA_COMPILERS += lrelease_en

TR_RU_QM = meego-lines-ru.qm
TR_RU_TS = $$TR_DIR/harbour-lines-ru.ts
lrelease_ru.input = TR_RU_TS
lrelease_ru.output = $$TR_DIR/$$TR_RU_QM
lrelease_ru.commands = $$LRELEASE $$TR_RU_TS -qm $$TR_DIR/$$TR_RU_QM
lrelease_ru.CONFIG = no_link
lrelease_ru.variable_out = PRE_TARGETDEPS
QMAKE_EXTRA_COMPILERS += lrelease_ru

# Deployment.
INSTALL_PREFIX = /opt/$$TARGET

TR_DEPLOY = $$INSTALL_PREFIX/translations
translation_en.files = translations/$$TR_EN_QM
translation_en.path = $$TR_DEPLOY
translation_ru.files = translations/$$TR_RU_QM
translation_ru.path = $$TR_DEPLOY
INSTALLS += translation_en translation_ru

qml_common.files = qml/common
qml_common.path = $$INSTALL_PREFIX/qml
INSTALLS += qml_common

qml_meego.files = qml/meego
qml_meego.path = $$INSTALL_PREFIX/qml
INSTALLS += qml_meego

desktopfile.files = meego/$${TARGET}.desktop
desktopfile.path = /usr/share/applications
INSTALLS += desktopfile

icon.files = meego/$${TARGET}.png
icon.path = /usr/share/icons/hicolor/80x80/apps
INSTALLS += icon

splash.files = meego/splash-*.png
splash.path = $$INSTALL_PREFIX
INSTALLS += splash

target.path = $$INSTALL_PREFIX/bin
INSTALLS += target
