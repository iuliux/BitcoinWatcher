using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class BitcoinWatcherView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    
    function onPrice(bcp) {
		var lastPriceValue = Lang.format("$1$", [bcp.lastPrice.format("%.2f")]);
    		//Sys.println(lastPriceValue);

		var refreshing = findDrawableById("PriceRefreshing");
		var value = findDrawableById("PriceValue");

		if (refreshing) {
    			refreshing.setColor(Gfx.COLOR_BLACK);  // hide the refreshing label
    		}
    		if (value) {
    			value.setText(lastPriceValue);
    		}
    		Ui.requestUpdate();
    }
    
    function onRefreshing() {
    		//Sys.println("Refreshing");
    		
    		var refreshing = findDrawableById("PriceRefreshing");
    		if (refreshing) {
    			refreshing.setColor(Gfx.COLOR_DK_GRAY);
    		}
    		Ui.requestUpdate();
    }
}
