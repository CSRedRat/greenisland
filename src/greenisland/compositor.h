/****************************************************************************
 * This file is part of Green Island.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#ifndef COMPOSITOR_H
#define COMPOSITOR_H

#include <QtCompositor/waylandcompositor.h>
#include <QQuickView>

class DesktopShellServer;

class Compositor : public QQuickView, public WaylandCompositor
{
    Q_OBJECT
    Q_PROPERTY(QRectF availableGeometry READ availableGeometry WRITE setAvailableGeometry NOTIFY availableGeometryChanged)
    Q_PROPERTY(WaylandSurface *currentSurface READ currentSurface WRITE setCurrentSurface NOTIFY currentSurfaceChanged)
public:
    explicit Compositor();

    QRectF availableGeometry() const;
    void setAvailableGeometry(const QRectF &rect);

    WaylandSurface *currentSurface() const {
        return m_currentSurface;
    }

    void surfaceCreated(WaylandSurface *surface);
    void surfaceAboutToBeDestroyed(WaylandSurface *surface);

signals:
    void windowAdded(QVariant window);
    void windowDestroyed(QVariant window);
    void windowResized(QVariant window);
    void availableGeometryChanged();
    void currentSurfaceChanged();

public slots:
    void destroyWindow(QVariant window);
    void destroyClientForWindow(QVariant window);

    void setCurrentSurface(WaylandSurface *surface);

private slots:
    void surfaceMapped();
    void surfaceUnmapped();
    void surfaceDestroyed(QObject *object);
    void frameSwapped();

protected:
    void resizeEvent(QResizeEvent *event);

private:
    QRectF m_availableGeometry;
    WaylandSurface *m_currentSurface;
    DesktopShellServer *m_desktopShell;
};

#endif // COMPOSITOR_H
