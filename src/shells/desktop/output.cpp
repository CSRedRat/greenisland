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

#include <QGuiApplication>
#include <QScreen>
#include <QQuickWindow>

#include <qpa/qplatformnativeinterface.h>

#include "output.h"
#include "overlay.h"
#include "waylandintegration.h"

Output::Output(QScreen *screen)
    : QObject()
    , m_screen(screen)
    , m_overlay(0)
    , m_overlaySurface(0)
{
    // Native platform interface
    m_native = QGuiApplication::platformNativeInterface();

    // Get native wl_output for the current screen
    m_output = static_cast<struct wl_output *>(
                m_native->nativeResourceForScreen("output", screen));
}

void Output::setOverlay(Overlay *overlay)
{
    if (!overlay)
        return;

    m_overlay = overlay;
    m_overlaySurface = static_cast<struct wl_surface *>(
                m_native->nativeResourceForWindow("surface",
                                                  overlay->window()));
}

void Output::sendPanelGeometry()
{
}

void Output::sendLauncherGeometry()
{
}

void Output::panelGeometryChanged(const QRect &geometry)
{
    WaylandIntegration *integration = WaylandIntegration::instance();
    desktop_shell_set_panel_geometry(integration->shell, m_output,
                                     geometry.x(), geometry.y(),
                                     geometry.width(), geometry.height());
}

void Output::launcherGeometryChanged(const QRect &geometry)
{
    WaylandIntegration *integration = WaylandIntegration::instance();
    desktop_shell_set_launcher_geometry(integration->shell, m_output,
                                        geometry.x(), geometry.y(),
                                        geometry.width(), geometry.height());
}

#include "moc_output.cpp"
