/****************************************************************************
 * This file is part of Desktop Shell.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QQuickWindow>
#include <QScreen>

#include "panel.h"

Panel::Panel(QScreen *screen, QObject *parent)
    : QObject(parent)
{
    // Engine
    m_engine = new QQmlEngine(this);
    m_engine->rootContext()->setContextProperty(
                QStringLiteral("PanelObject"), this);

    // Load component
    m_component = new QQmlComponent(m_engine, this);
    m_component->loadUrl(QUrl("qrc:///qml/Panel.qml"));
    if (!m_component->isReady())
        qFatal(qPrintable(m_component->errorString()));

    // Create component
    QObject *topLevel = m_component->create();
    m_window = qobject_cast<QQuickWindow *>(topLevel);
    if (!m_window)
        qFatal("Error: Panel root item must be a Window!\n");
    m_window->setScreen(screen);

    // This is a frameless window that stays on top of everything
    m_window->setFlags(Qt::WindowStaysOnTopHint | Qt::CustomWindow);

    // Create the platform window
    m_window->create();

    // Set screen size and detect geometry changes
    updateScreenGeometry();
    connect(screen, SIGNAL(geometryChanged(QRect)),
            this, SLOT(updateScreenGeometry(QRect)));
}

Panel::~Panel()
{
    delete m_component;
    delete m_engine;
}

void Panel::configure()
{
    QRect geometry;
    geometry.setTopLeft(QPoint(0, 0));
    geometry.setSize(QSize(100, 48));
    m_window->setGeometry(geometry);
}

void Panel::updateScreenGeometry()
{
    updateScreenGeometry(m_window->screen()->availableGeometry());
}

void Panel::updateScreenGeometry(const QRect &geometry)
{
    m_window->setProperty("screenSize", geometry.size());
    configure();
}

#include "moc_panel.cpp"
