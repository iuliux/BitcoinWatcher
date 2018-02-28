using Toybox.Application as App;

class BitcoinWatcherApp extends App.AppBase {

	hidden var mModel;
    hidden var mView;
    hidden var mNavigation;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    		mView = new BitcoinWatcherView();
        mModel = new PriceModel(mView.method(:onPrice), mView.method(:onRefreshing));
        mNavigation = new Navigation(mModel);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ mView, mNavigation ];
    }

}