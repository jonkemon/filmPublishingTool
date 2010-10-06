package com.telecoms.media.videowizard.control
{

	import com.telecoms.media.videowizard.model.vo.UploadStatus;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.containers.Panel;
	
	public class UploadVideoFilesClass extends Panel
	{
		public var uploadFolderSelect:String;
		
		[Bindable]
		public var _fileStatus:UploadStatus = new UploadStatus();
		
		private var urlRequest:URLRequest;
		private var fileReferenceList:FileReferenceList;
		private var fileReference:FileReference;
		private var serverSideScript:String = "http://media2.telecoms.com/cdn/videowizard/upload.php";
		private var eventDispatcherButton:EventDispatcher;
		
		//Final URL for script http://media2.telecoms.com/cdn/videowizard/upload.php

		public function UploadVideoFilesClass()
		{
			urlRequest = new URLRequest(serverSideScript);
			fileReferenceList = new FileReferenceList();
			fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler);
		}

		public function uploadFile():void 
		{
			var imageTypes:FileFilter = new FileFilter("Videos (*.f4v, *.flv, *.mov)", "*.f4v; *.flv; *.mov");
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
			//trace('file uploaded');
			//fileStatus.uploadStatus;
			_fileStatus.uploadStatus = "File Uploaded";
			trace(_fileStatus.uploadStatus);
		}	

	}
}