/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.view
{	
	import org.puremvc.as3.demos.flex.weborb.login.ApplicationFacade;
	import org.puremvc.as3.demos.flex.weborb.login.model.LoginProxy;
	import org.puremvc.as3.demos.flex.weborb.login.view.components.LoggedInBox;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * A Mediator for interacting with the LoggedInBox component.
	 */		
	public class LoggedInBoxMediator extends Mediator implements IMediator
	{

		private var loginProxy: LoginProxy;

		public static const NAME:String = 'LoggedInBoxMediator';

		/**
		 * Constructor. 
		 * @param object the viewComponent
		 */					
		public function LoggedInBoxMediator(viewComponent:Object) 
		{
			super(NAME, viewComponent);
						
			loginProxy = LoginProxy(facade.retrieveProxy(LoginProxy.NAME));
			
		}

		/**
		 * List all notifications this Mediator is interested in.
		 * 
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array 
		{
			return [ ApplicationFacade.LOGIN_SUCCES ];
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
				case ApplicationFacade.LOGIN_SUCCES:
					loggedInBox.loginVO = loginProxy.loggedInVO;
				break;
				default:

			}
		}		
		
		/**
		 * Cast the viewComponent to its actual type.
		 * @return app the viewComponent cast to LoggedInBox
		 */
		protected function get loggedInBox(): LoggedInBox
		{
			return viewComponent as LoggedInBox;
		}
	}
}