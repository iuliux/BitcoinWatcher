using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class Navigation extends Ui.BehaviorDelegate {
	hidden var mModel;

  	function initialize(priceModel) {
	    	mModel = priceModel;
	    	
	    	BehaviorDelegate.initialize();
    }

	function onSelect() {
		mModel.makePriceRequests("USD");
		return true;
	}
}