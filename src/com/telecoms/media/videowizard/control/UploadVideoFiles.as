package com.telecoms.media.videowizard.control
{

	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import com.telecoms.media.videowizard.event.eventsDispatch;
	import flash.events.EventDispatcher;
	
	public class UploadVideoFiles
	{
		
		private var urlRequest:URLRequest;
		private var fileReferenceList:FileReferenceList;
		private var fileReference:FileReference;
		private var serverSideScript:String = "http://www.mazieswake.co.uk/php/videowizard/php/upload.php";
		private var eventDispatcherButton:EventDispatcher;

		//Actual PHP script location is http://media2.telecoms.com/cdn/videowizard/php/upload.php

		public function UploadVideoFiles()
		{
			urlRequest = new URLRequest(serverSideScript);
			fileReferenceList = new FileReferenceList();
			fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler);	
		}

		public function uploadFile():void 
		{
			var imageTypes:FileFilter = new FileFilter("Videos (*.f4v, *.flv, *.mov, *.png)", "*.f4v; *.flv; *.mov; *.png");
			var allTypes:Array = new Array(imageTypes);
			fileReferenceList.browse(allTypes);
		}
		
		private function fileSelectedHandler(event:Event):void 
		{
			var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
			var fileList:Array = fileReferenceList.fileList;

			// get the first file that the user chose
			fileReference = FileReference(fileList[0]);
			
			// update the status text
			//statusText.text = "Uploading...";
		}

		public function uploadFileHandler(folderLocation:String):void 
		{		
			var folderLocationXML:XML = folderLocation as XML;
			var variables:URLVariables = new URLVariables(folderLocationXML);
			var loader:URLLoader = new URLLoader();
			
			variables.folder = folderLocation;
			urlRequest.data = variables;
			urlRequest.method = URLRequestMethod.POST;
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.load(urlRequest);
			
			// upload the file to the server side script
			fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler);
			fileReference.upload(urlRequest);
		}
		
		private function uploadCompleteHandler(event:Event):void 
		{
			//statusText.text = "File Uploaded: " + event.target.name;
			trace('file uploaded');
			eventDispatcherButton.dispatchEvent(new eventsDispatch("UPLOADED"));
		}	

	}
}