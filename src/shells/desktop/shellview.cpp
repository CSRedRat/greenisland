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
#include <QWindow>
#include <QQmlContext>
#include <QQuickItem>
#include <QScreen>

#include "shellview.h"
#include "desktopshellintegration.h"

ShellView::ShellView(DesktopShell *shell)
    : ShellQuickView(shell)
{
    // This is a frameless window that stays on top of everything
    setTitle(QLatin1String("Desktop Shell"));
    setFlags(Qt::WindowStaysOnTopHint | Qt::FramelessWindowHint);

    // Make it transparent
    QSurfaceFormat surfaceFormat;
    surfaceFormat.setSamples(16);
    surfaceFormat.setAlphaBufferSize(8);
    setFormat(surfaceFormat);
    setClearBeforeRendering(true);
    setColor(QColor(Qt::transparent));
    winId();

    // Set context properties
    rootContext()->setContextProperty("shell", shell);
    rootContext()->setContextProperty("quickview", this);

    // Load QML view
    setSource(QUrl("qrc:///qml/Shell.qml"));
    setResizeMode(QQuickView::SizeRootObjectToView);
}

QRectF ShellView::availableGeometry() const
{
    return rootObject()->property("availableGeometry").toRectF();
}

#include "moc_shellview.cpp"
