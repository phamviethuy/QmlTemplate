import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

import ThemeEngine 1.0

T.GroupBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 12
    padding: 12

    topPadding: title ? 4 + (implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0) : padding

    // colors
    property string backgroundColor: Theme.colorForeground
    property string borderColor: Theme.colorSeparator

    ////////////////

    background: Rectangle {
        y: control.topPadding - control.bottomPadding
        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding

        radius: Theme.componentRadius
        color: control.backgroundColor
        border.width: 2
        border.color: control.borderColor
    }

    ////////////////

    label: Text {
        x: control.leftPadding
        width: control.availableWidth

        text: control.title
        color: Theme.colorText
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    ////////////////
}
