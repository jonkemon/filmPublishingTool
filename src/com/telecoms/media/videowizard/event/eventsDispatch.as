package com.telecoms.media.videowizard.event
{
 	import flash.events.Event;
 	
	public class eventsDispatch extends Event
	{
  		public static const CONTROL_TYPE:String = "buttonControl";
  		public var command:String;
  		
		public function eventsDispatch(command:String)
		{
   			super( CONTROL_TYPE);
   			this.command = command;
   			trace(this);
		}

	}
}