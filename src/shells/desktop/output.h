/****************************************************************************
 * This file is part of Desktop Shell.
 *
 * Copyright (C) 2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#ifndef OUTPUT_H
#define OUTPUT_H

#include <QObject>

#include <wayland-client.h>

class QPlatformNativeInterface;
class QScreen;

class Overlay;

class Output : public QObject
{
    Q_OBJECT
public:
    explicit Output(QScreen *screen);

    QScreen *screen() const {
        return m_screen;
    }

    struct wl_output *output() const {
        return m_output;
    }

    Overlay *overlay() const {
        return m_overlay;
    }

    struct wl_surface *overlaySurface() const {
        return m_overlaySurface;
    }

    void setOverlay(Overlay *overlay);

public Q_SLOTS:
    void sendPanelGeometry();
    void sendLauncherGeometry();

private:
    QPlatformNativeInterface *m_native;

    QScreen *m_screen;
    struct wl_output *m_output;

    Overlay *m_overlay;
    struct wl_surface *m_overlaySurface;

private Q_SLOTS:
    void panelGeometryChanged(const QRect &geometry);
    void launcherGeometryChanged(const QRect &geometry);
};

#endif // OUTPUT_H
