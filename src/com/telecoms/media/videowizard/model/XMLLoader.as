package com.telecoms.media.videowizard.model
{
	import mx.rpc.http.mxml.HTTPService;
	
	public class XMLLoader extends HTTPService
	{
		public function XMLLoader()
		{
		}
		
		// Confirm XML loaded
		public function xmlReturned(event:Event):void{
			var dispatchMe:Event = new Event("XML has loaded");
			dispatchEvent(dispatchMe);
			trace(dispatchMe);
		}

		// Confirm XML failure
		public function xmlError(event:Event):void{
			trace('Xml failure to load');
		}	

	}
}