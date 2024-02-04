import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class CaloriesController {
  var mValue as String;
  var mUnit as String;
  var mDeviceSupportsComplications as Boolean;
  var mComplicationId as Complications.Id?;

  function initialize() {
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    mUnit = "";
    mDeviceSupportsComplications = Utils.Complications.hasComplicationSupport();

    if (mDeviceSupportsComplications) {
      mComplicationId = new Complications.Id(Complications.COMPLICATION_TYPE_CALORIES);
      Utils.Complications.registerToComplicationChangeCallback(
        mComplicationId,
        self.method(:onComplicationUpdate)
      );
    }
  }

  function onComplicationUpdate(complicationId as Complications.Id) as Void {
    if (!complicationId.equals(mComplicationId as Complications.Id)) {
      return;
    }
    var comp = Complications.getComplication(complicationId);

    mValue =
      comp[:value] != null
        ? comp[:value] + ""
        : Application.loadResource(Rez.Strings.UnknownValue) as String;

    mUnit = comp[:unit] != null ? comp[:unit] + "" : "";
  }

  function updateValueForLegacyDevices() as Void {
    var calories = ActivityMonitor.getInfo().calories;

    if (calories == null) {
      mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
      return;
    }

    mValue = calories.format("%i");
  }

  function getValue() as String {
    if (!mDeviceSupportsComplications) {
      updateValueForLegacyDevices();
    }

    return mValue;
  }

  function getLabel() as String {
    return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
  }

  function getUnit() as String {
    if (!mDeviceSupportsComplications) {
      mUnit = "";
    }

    return mUnit;
  }
}
