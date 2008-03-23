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
	
	import org.puremvc.as3.demos.flex.weborb.login.model.vo.LoginVO;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * A Proxy for storing users data and sending and retrieving data to/from its remoting service
	 * 
	 */
	public class LoginProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = 'loginProxy';
		//
		// Notification name constants
		public static const LOGIN_FAILED: String = "loginFailed";
		public static const LOGIN_SUCCESS: String = "loginSucces";	
		//
		// login service				
		private var _loginService: RemoteObject;
		//
		// error message
		public var faultMessage: String;
		//
		// other part of the model
		private var _appProxy: ApplicationProxy;
		
		/**
		 * Constructor
		 * 
		 * @param Proxy's data if necessary
		 */		
		public function LoginProxy (data:Object=null) 
		{
			super(NAME, new LoginVO() );
			
			//
			// A local reference to another part of the model
			// Note: Be carefull that the ApplicationProxy has already registered within
			// the ModelPrepCommand before
			_appProxy = facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;
			//
			// login service
			_loginService = new RemoteObject();
			_loginService.destination = "GenericDestination";
			_loginService.source = "org.puremvc.as3.demos.flex.weborb.login.LoginFacade";
			
			_loginService.getUser.addEventListener(ResultEvent.RESULT, getUserResult); 
			_loginService.addEventListener(FaultEvent.FAULT, getUserFailed);
	
		}
		
		/**
		 * Calls the remoting service passing users data
		 * 
		 * @param 	users data as LoginVO
		 */			
		public function getUser( vo: LoginVO ):void
		{
			_loginService.getUser( vo );		
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
			
			//
			// populate its data object using the result
			var loginVO: LoginVO = event.result as LoginVO
			loginVO.loginDate = new Date();
			setData( loginVO );
			//
			// change the view state
			_appProxy.viewState = ApplicationProxy.LOGGED_IN_STATE;
			//
			// notify all interested members
			sendNotification( LoginProxy.LOGIN_SUCCESS );
		}

		/**
		 * Receives the remoting service fault event
		 * 
		 * @param 	fault event object
		 */	
		private function getUserFailed(event: FaultEvent): void 
		{
			faultMessage = event.fault.faultString;
			CursorManager.removeBusyCursor();
			//
			// change the view state	
			_appProxy.viewState = ApplicationProxy.LOGIN_ERROR_STATE;	
			//
			// notify all interested members			
			sendNotification( LoginProxy.LOGIN_FAILED );
		}
		
		/**
		 * Getter for its data object casted as LoginVO
		 * 
		 * @return 	LoginVO
		 */			
		public function get loginVO(): LoginVO
		{
			return data as LoginVO;
		}				
	}
}