import QtQuick 2.12
import QtGraphicalEffects 1.0

Item
{
  id: control

  implicitWidth:  100
  implicitHeight: 100

  visible: false

  property double wave_offset: 0.0
  property color  wave_color:  "red"
  property bool   pressed:     false
  property real   pressX:      0
  property real   pressY:      0


  RadialGradient
  {
    id:           gradient
    anchors.fill: parent

    gradient: Gradient
    {
      GradientStop
      {
        position: ( control.wave_offset > 0.1 ) ? ( control.wave_offset-0.1 ) : 0
        color:    "transparent"
      }

      GradientStop { position: control.wave_offset+0.09; color: control.wave_color }
      GradientStop { position: control.wave_offset+0.11; color: "transparent"  }
    }
  }

  onPressedChanged:
  {
    if ( control.pressed )
    {
      control.click( control.pressX, control.pressY );
    }
  }

  PropertyAnimation
  {
    id:         gradientAnimation
    target:     control
    property:   "wave_offset"

    from:       0
    to:         0.4

    duration:   750
    running:    false

    onStarted:  control.visible = true
    onFinished: control.visible = false
  }

  function click( ptx,pty )
  {
    gradientAnimation.stop()
    control.x = ptx - control.width / 2
    control.y = pty - control.height / 2
    gradientAnimation.start()
  }
}
