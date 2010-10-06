package com.telecoms.media.videowizard.model.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class UploadStatus extends EventDispatcher
	{
		public static var STATUS_CHANGE:String = "nameChange";
		private var _uploadStatus:String = "Choose your file...";
		
		public function UploadStatus()
		{
			
		}
		
		[Bindable(event="STATUS_CHANGE")]
		public function get uploadStatus():String
		{
			return _uploadStatus;
		}
		
		public function set uploadStatus(value:String):void
		{
			_uploadStatus = value;
			var dispatchMe:Event = new Event("STATUS_CHANGE");
			dispatchEvent(dispatchMe);
			trace(dispatchMe);
		}
	}
}