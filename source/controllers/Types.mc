import Toybox.Lang;
import Toybox.WatchUi;

module Types {
  typedef ValueController as interface {
    function getValue() as String;
  };

  typedef LabeledValueController as interface {
    function getValue() as String;
    function getLabel() as String;
  };

  typedef IconController as interface {
    function getIcon() as WatchUi.BitmapResource;
    function getLabel() as String;
    function getValue() as String;
    function shouldDraw() as Boolean;
  };

  typedef ArcController as interface {
    function getAngle() as Number;
    function getLabel() as String;
    function getValue() as String;
  };

  typedef Controller as ArcController or
    IconController or
    LabeledValueController or
    ValueController;
}
