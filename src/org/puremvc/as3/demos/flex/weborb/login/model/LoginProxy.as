/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.model
{
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.puremvc.as3.demos.flex.weborb.login.ApplicationFacade;
	import org.puremvc.as3.demos.flex.weborb.login.model.vo.LoginVO;
	import org.puremvc.interfaces.*;
	import org.puremvc.patterns.proxy.Proxy;
	
	/**
	 * A Proxy for storing users data and sending and retrieving data to/from its remoting service
	 */
	public class LoginProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = 'loginProxy';
				
		private var loginService: RemoteObject;
		
		public var faultMessage: String;
		public var loggedInVO: LoginVO;

		/**
		 * Constructor
		 * 
		 * @param Proxy's data if necessary
		 */		
		public function LoginProxy (data:Object=null) 
		{
			super(NAME,data);
			
			loginService = new RemoteObject();
			loginService.destination = "GenericDestination";
			loginService.source = "org.puremvc.as3.demos.flex.weborb.login.Login";
			
			loginService.getUser.addEventListener(ResultEvent.RESULT, getUserResult); 
			loginService.addEventListener(FaultEvent.FAULT, getUserFailed);
	
		}
		
		/**
		 * Calls the remoting service passing users data
		 * 
		 * @param 	users data as LoginVO
		 */			
		public function getUser(vo:LoginVO):void
		{
			loginService.getUser(vo);		
			CursorManager.setBusyCursor();
		}

		/**
		 * Receives the remoting service result users data
		 * 
		 * @param 	result event object
		 */			
		private function getUserResult(event: ResultEvent):void
		{
			CursorManager.removeBusyCursor();
			
			loggedInVO = event.result as LoginVO;
			loggedInVO.loginDate = new Date();
			
			sendNotification(ApplicationFacade.LOGIN_SUCCES);
		}

		/**
		 * Receives the remoting service fault event
		 * 
		 * @param 	fault event object
		 */	
		private function getUserFailed(event: FaultEvent):void 
		{
			faultMessage = event.fault.faultString;
			CursorManager.removeBusyCursor();
			
			sendNotification(ApplicationFacade.LOGIN_FAILED);
		}				
	}
}