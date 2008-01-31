/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.view
{	
	import flash.events.Event;
	
	import org.puremvc.as3.demos.flex.weborb.login.ApplicationFacade;
	import org.puremvc.as3.demos.flex.weborb.login.model.LoginProxy;
	import org.puremvc.as3.demos.flex.weborb.login.model.vo.LoginVO;
	import org.puremvc.as3.demos.flex.weborb.login.view.components.LoginPanel;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	
	/**
	 * A Mediator for interacting with the LoginPanel component.
	 */	
	public class LoginPanelMediator extends Mediator implements IMediator
	{

		private var loginProxy: LoginProxy;

		public static const NAME:String = 'LoginPanelMediator';

		/**
		 * Constructor. 
		 * @param object the viewComponent
		 */				
		public function LoginPanelMediator(viewComponent:Object) 
		{
			super(NAME, viewComponent);
			
			loginProxy = LoginProxy(facade.retrieveProxy(LoginProxy.NAME));

			loginPanel.addEventListener( LoginPanel.LOGIN, login);
			
		}

		/**
		 * List all notifications this Mediator is interested in.
		 * 
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array 
		{
			return [ ApplicationFacade.LOGIN_FAILED ];
		}

		/**
		 * Handle all notifications this Mediator is interested in.
		 * 
		 * @param INotification a notification 
		 */
		override public function handleNotification( note:INotification ):void 
		{
			switch (note.getName()) 
			{
				case ApplicationFacade.LOGIN_FAILED:
					loginFault(note.getBody());
				break;
				default:

			}
		}		


		/**
		 * The user has initiated to log in.
		 */
		private function login (event:Event=null):void
		{			
			var loginVO: LoginVO = new LoginVO();
			loginVO.username = loginPanel.username.text;
			loginVO.password = loginPanel.password.text;

			sendNotification(ApplicationFacade.LOGIN, loginVO);
		}

		/**
		 * Shows an error message on login panel
		 * @param message
		 */		
		private function loginFault (message: Object):void
		{
			loginPanel.statusMessage.htmlText = "<font color='#FF6600'>" + loginProxy.faultMessage + "</font>";
		}

		/**
		 * Cast the viewComponent to its actual type.
		 * @return app the viewComponent cast to LoginPanel
		 */
		protected function get loginPanel(): LoginPanel
		{
			return viewComponent as LoginPanel;
		}
	}
}