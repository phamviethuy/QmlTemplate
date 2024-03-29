import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

//import QtGraphicalEffects 1.15 // Qt5
import Qt5Compat.GraphicalEffects // Qt6

import ThemeEngine 1.0
import "qrc:/js/UtilsNumber.js" as UtilsNumber

T.SpinBox {
    id: control
    implicitWidth: 128
    implicitHeight: Theme.componentHeight

    value: 50
    editable: true

    font.pixelSize: Theme.componentFontSize
    opacity: enabled ? 1 : 0.4

    property string legend

    ////////////////

    background: Rectangle {
        implicitWidth: 128
        implicitHeight: Theme.componentHeight

        radius: Theme.componentRadius
        color: Theme.colorComponentBackground

        Rectangle {
            width: control.height
            height: control.height / 2
            x: control.mirrored ? 0 : control.width - width
            y: 0
            color: control.up.pressed ? Theme.colorComponentDown : Theme.colorComponent
        }
        Rectangle {
            width: control.height
            height: control.height / 2
            x: control.mirrored ? 0 : control.width - width
            y: height
            color: control.down.pressed ? Theme.colorComponentDown : Theme.colorComponent
        }

        Rectangle {
            anchors.fill: parent
            radius: Theme.componentRadius
            color: "transparent"
            border.width: Theme.componentBorderWidth
            border.color: control.focus ? Theme.colorPrimary : Theme.colorComponentBorder
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                x: control.x
                y: control.y
                width: control.width
                height: control.height
                radius: Theme.componentRadius
            }
        }
    }

    ////////////////

    contentItem: Item {
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: control.height + 8

        Row {
            anchors.centerIn: parent
            spacing: 2

            TextInput {
                height: control.height
                anchors.verticalCenter: parent.verticalCenter

                color: Theme.colorComponentText
                selectionColor: Theme.colorPrimary
                selectedTextColor: "white"
                selectByMouse: control.editable

                text: control.value
                font: control.font
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !control.editable
                validator: control.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly

                onEditingFinished: {
                    var v = parseInt(text)
                    if (text.length <= 0) v = control.from
                    if (isNaN(v)) v = control.from
                    if (v < control.from) v = control.from
                    if (v > control.to) v = control.to

                    control.value = v
                    text = v

                    control.focus = false
                    control.valueModified()
                }
            }

            Text {
                height: control.height
                anchors.verticalCenter: parent.verticalCenter

                visible: control.legend
                color: Theme.colorComponentText
                opacity: 0.8

                text: control.legend
                textFormat: Text.PlainText
                font: control.font
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }
        }
    }

    ////////////////

    up.indicator: Item {
        implicitWidth: Theme.componentHeight
        implicitHeight: Theme.componentHeight

        width: control.height
        height: control.height / 2
        x: control.mirrored ? 0 : control.width - width
        y: 0

        opacity: enabled ? 1 : 0.33

        Canvas {
            id: arrowup
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 2
            width: 12
            height: 6
            rotation: 180

            Connections {
                target: ThemeEngine
                function onCurrentThemeChanged() { arrowup.requestPaint() }
            }

            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.moveTo(0, 0)
                ctx.lineTo(width, 0)
                ctx.lineTo(width / 2, height)
                ctx.closePath()
                ctx.fillStyle = Theme.colorIcon
                ctx.fill()
            }
        }
    }

    ////////////////

    down.indicator: Item {
        implicitWidth: Theme.componentHeight
        implicitHeight: Theme.componentHeight

        width: control.height
        height: control.height / 2
        x: control.mirrored ? 0 : control.width - width
        y: height

        opacity: enabled ? 1 : 0.33

        Canvas {
            id: arrowdown
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -2
            width: 12
            height: 6
            rotation: 0

            Connections {
                target: ThemeEngine
                function onCurrentThemeChanged() { arrowdown.requestPaint() }
            }

            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.moveTo(0, 0)
                ctx.lineTo(width, 0)
                ctx.lineTo(width / 2, height)
                ctx.closePath()
                ctx.fillStyle = Theme.colorIcon
                ctx.fill()
            }
        }
    }

    ////////////////
}
