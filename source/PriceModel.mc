using Toybox.Communications as Comm;
using Toybox.Time as Time;
using Toybox.System as Sys;
using Toybox.Math as Mt;


class BitcoinPrice {
	var currency;  // USD or EUR
	var lastPrice = 0.0;
	var time = "";  // time in UTC for lastPrice as string, e.g. Mar 30, 2015 17:20:00 UTC

	var history = null;
}


class PriceModel {
	var bcp = null;  // type BitcoinPrice

	hidden var mActiveReq = null;
	
	hidden var baseURL = "https://api.coindesk.com/v1/bpi/";
	hidden var historicalDays = 5;
	hidden var notify;
	hidden var refreshing;

  	function initialize(handler, pending) {
        notify = handler;
        refreshing = pending;
        
        makePriceRequests("USD");    				 
    }
    
    function makePriceRequests(currency) {
    		// Comment when using simulator
		//var settings = Sys.getDeviceSettings();
		// documented: phoneConnected is missing in vivoactive FW 2.30
		//if(settings has :phoneConnected and !settings.phoneConnected){ notify.invoke("Phone\nnot\nconnected"); return; }
	
		if (Toybox has :Communications) {
			refreshing.invoke();
		
			bcp = null;
			mActiveReq = currency;
			
			var headers = {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_URL_ENCODED, "Accept" => "application/json"};
			
			// get last price
			Comm.makeWebRequest(baseURL + "currentprice/" + currency + ".json",
		         				{}, 
		         				{
		         					:headers => headers,
					                :method => Comm.HTTP_REQUEST_METHOD_GET,
					                :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
					            }, 
		         				method(:onReceivePrice));
			
      	} else {
      		notify.invoke("Communication\nnot\npossible");
      	} 
    
    }

	function onReceivePrice(responseCode, data) {
        if(responseCode == 200) {
        		if(bcp == null) 	{
	            	bcp = new BitcoinPrice();
	            	bcp.currency = mActiveReq;
			}
            
            bcp.lastPrice = data["bpi"][mActiveReq]["rate_float"].toFloat();
            bcp.time = data["time"]["updated"];
            
            notify.invoke(bcp);
            
            mActiveReq = null;
        } else {
	        	handleError(responseCode, data);
	        	mActiveReq = null;
        }
    }
    
    function handleError(responseCode, data) {
    		if(responseCode == 408) {  // Request Timeout
			notify.invoke("Data request\ntimed out");
		} else {
            notify.invoke("Data request\nfailed\nError: " + responseCode.toString());
        }
    }

}