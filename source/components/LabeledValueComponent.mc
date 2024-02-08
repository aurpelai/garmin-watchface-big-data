import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class LabeledValueComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.LabeledValueController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mLabel as String;
  hidden var mValue as String;

  public function initialize(params as Types.Components.LabeledValueParams) {
    mController =
      Utils.Controller.getController(params[:controller] as Types.Controllers.Id) as
      Types.Controllers.LabeledValueController;
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mLabel = Application.loadResource(Rez.Strings.Unknown) as String;
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    Drawable.initialize(params);
  }

  function draw(dc as Graphics.Dc) as Void {
    var LABEL_FONT = Graphics.FONT_XTINY;
    var VALUE_FONT = Graphics.FONT_TINY;
    var LABEL_HEIGHT = dc.getFontHeight(LABEL_FONT) * 1.1;

    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      mLabel = mController.getLabel();
      mValue = mController.getValue();
      mUpdated = Time.now();
    }

    dc.setColor(Constants.Color.SECONDARY, Graphics.COLOR_TRANSPARENT);
    dc.drawText(
      locX,
      locY,
      LABEL_FONT,
      mLabel,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );

    dc.setColor(Constants.Color.PRIMARY, Graphics.COLOR_TRANSPARENT);
    dc.drawText(
      locX,
      locY + LABEL_HEIGHT,
      VALUE_FONT,
      mValue,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}
