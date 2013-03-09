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

#ifndef PANEL_H
#define PANEL_H

class QQmlEngine;
class QQmlComponent;
class QQuickWindow;

class Panel : public QObject
{
    Q_OBJECT
public:
    explicit Panel(QScreen *screen, QObject *parent = 0);
    ~Panel();

    QQuickWindow *window() const {
        return m_window;
    }

public Q_SLOTS:
    void configure();

    void updateScreenGeometry();
    void updateScreenGeometry(const QRect &geometry);

private:
    QQmlEngine *m_engine;
    QQmlComponent *m_component;
    QQuickWindow *m_window;
};

#endif // PANEL_H
