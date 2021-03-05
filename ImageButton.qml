import QtQuick 2.0
import QtGraphicalEffects 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.12



Button
{
  id: control

  property string source:               ""
  property int    fillMode:             Image.PreserveAspectFit
  property double imageOpacity:         1.0
  property double radius:               10
  property color  waveColor:            "#55c9c9c9"
  property color  fixedBackgroundColor: "transparent"
  property color  backgroundColor:      "transparent"
  property color  backgroundHoverColor: "#55aaaaaa"

  contentItem: Image
  {
    id: image

    source:   control.source
    fillMode: control.fillMode
    opacity:  control.imageOpacity
  }

  background: Rectangle
  {
    id: background

    clip:   true
    color:  control.backgroundColor
    radius: control.radius

    ClickWave
    {
      id: clickWave

      width:  parent.width * 3
      height: parent.height * 3

      wave_color: control.waveColor
    }
  }

  MouseArea
  {
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true

    onPressed:
    {
      opacityBrightAnimation.stop();
      opacityDimAnimation.start();
      clickWave.click( mouse.x, mouse.y );
    }

    onReleased:
    {
      opacityDimAnimation.stop();
      opacityBrightAnimation.start();
    }

    onEntered:
    {
      exitedAnimation.stop();
      enteredAnimation.start();
    }

    onExited:
    {
      enteredAnimation.stop();
      exitedAnimation.start();
    }
  }

  PropertyAnimation
  {
    id: opacityDimAnimation
    target: control
    property: "imageOpacity"

    from: control.imageOpacity
    to: 0.5

    duration: 100
    running: false
  }

  PropertyAnimation
  {
    id: opacityBrightAnimation
    target: control
    property: "imageOpacity"

    from: control.imageOpacity
    to: 1.0

    duration: 100
    running: false
  }

  ColorAnimation
  {
    id: enteredAnimation
    target: control
    property: "backgroundColor"

    from: control.backgroundColor
    to: control.backgroundHoverColor

    duration: 250
    running: false
  }

  ColorAnimation
  {
    id: exitedAnimation
    target: control
    property: "backgroundColor"

    from: control.backgroundColor
    to: control.fixedBackgroundColor

    duration: 500
    running: false
  }
}

