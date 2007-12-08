/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.model
{
	import org.puremvc.as3.demos.flex.weborb.login.ApplicationFacade;
	import org.puremvc.interfaces.*;
	import org.puremvc.patterns.proxy.Proxy;
	

	public class ApplicationProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = 'ApplicationProxy';

		private var _workflowState: uint;

		public static const VIEWING_LOGIN_SCREEN : uint = 1;
		public static const VIEWING_LOGGED_IN_SCREEN : uint = 2;
		public static const VIEWING_ERROR_SCREEN : uint = 3;		

		/**
		 * Constructor
		 * 
		 * @param Proxy's data if necessary
		 */		
		public function ApplicationProxy (data:Object = null) 
		{
			super(NAME,data);		
		}
		
		/**
		 * Sets the state of the applications "workflow"
		 * 
		 * @param 	integer wich based on constants defined by ApplicationProxy
		 */
		public function set workflowState(value: uint): void
		{
			_workflowState = value;
			sendNotification( ApplicationFacade.APP_STATE );
		}

		/**
		 * Gets the state of the applications "workflow"
		 */				
		public function get workflowState(): uint
		{
			return _workflowState;
		}				
	}
}