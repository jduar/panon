import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0 as QQC2

QQC2.CheckBox {

    property var root
    property int index


    visible:root.effect_arguments.length>index
    text: visible?root.effect_arguments[index]["name"]:""
    checked:visible?(root.cfg_effectArgValues[index]=="true"):false

    onCheckedChanged:{
        root.cfg_effectArgValues[index]=checked
        root.cfg_effectArgTrigger=!root.cfg_effectArgTrigger
    }
}
