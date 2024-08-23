import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
import org.kde.plasma.core as PlasmaCore

KCM.SimpleKCM {
    id: root

    readonly property bool vertical: {
        if (plasmoid.formFactor == PlasmaCore.Types.Vertical) {
            return true;
        } else if (plasmoid.formFactor == PlasmaCore.Types.Planar) {
            return plasmoid.height > plasmoid.width;
        } else {
            return false;
        }
    }

    property alias cfg_fps: fps.value
    property alias cfg_showFps: showFps.checked
    property alias cfg_hideTooltip: hideTooltip.checked

    property alias cfg_preferredWidth: preferredWidth.value
    property alias cfg_autoExtend: autoExtend.checked
    property alias cfg_autoHide: autoHide.checked
    property alias cfg_animateAutoHiding: animateAutoHiding.checked

    property alias cfg_gravity: gravity.currentIndex
    property alias cfg_inversion: inversion.checked

    Kirigami.FormLayout {

        QQC2.SpinBox {
            id: fps
            Kirigami.FormData.label: i18nc("@label:spinbox", "FPS:")

            stepSize: 1
            from: 1
            to: 300
        }

        QQC2.Label {
            text: i18n("Lower FPS saves CPU and battery.")
        }

        QQC2.CheckBox {
            id: showFps
            text: i18nc("@option:radio", "Show FPS")
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        QQC2.CheckBox {
            id: autoHide
            text: i18nc("@option:radio", "Auto-hide (when audio is gone)")
            
            onCheckedChanged: {
                if (autoHide.checked) {
                    autoExtend.checked = false;
                }
            }
        }

        QQC2.CheckBox {
            id: animateAutoHiding
            visible: autoHide.checked
            text: i18nc("@option:radio", "Animate auto-hiding")
        }

        QQC2.SpinBox {
            id: preferredWidth

            Kirigami.FormData.label: {
                if (vertical) {
                    return i18nc("@label:spinbox", "Height:")
                } else {
                    return i18nc("@label:spinbox", "Width:")
                }
            }

            stepSize: 10
            from: 1
            to: 8000
        }

        QQC2.CheckBox {
            id: autoExtend
            enabled: !autoHide.checked
            text: {
                var word = vertical ? "height" : "width";
                return i18nc(
                    "@option:check",
                    "Fill " + word + " (doesn't work with Auto-hide)"
                )
            }
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        QQC2.ComboBox {
            id: gravity
            Kirigami.FormData.label: i18n("Gravity:")

            model: [
                i18n("Center"),
                i18n("North"),
                i18n("South"),
                i18n("East"),
                i18n("West"),
            ]
        }

        QQC2.CheckBox {
            id: inversion
            text: i18nc("@option:check", "Flip")
        }

        QQC2.CheckBox {
            id: hideTooltip
            text: i18nc("@option:check", "Hide tooltip")
        }

        QQC2.Label {
            Kirigami.FormData.label: i18n("Version:")
            text: "0.4.5"
        }

    }
}