/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.view
{
	
	import mx.core.Container;
	
	import org.puremvc.as3.demos.flex.weborb.login.model.ApplicationProxy;
	import org.puremvc.as3.demos.flex.weborb.login.model.LoginProxy;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * A Mediator for interacting with the top level Application.
	 */
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'ApplicationMediator';

		private var _appProxy: ApplicationProxy;
		private var _loginProxy: LoginProxy;
					
		/**
		 * Constructor. 
		 * 
		 * @param object the viewComponent
		 */
		public function ApplicationMediator( viewComponent: Login ) 
		{
			super(NAME, viewComponent);
			
			//
			// register the needed mediators for its child components
			facade.registerMediator(new LoginPanelMediator(app.login));
			facade.registerMediator(new LoggedInBoxMediator(app.loggedIn));
			//
			// local reference to the proxies
			_appProxy = facade.retrieveProxy(ApplicationProxy.NAME) as ApplicationProxy;
			_loginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;		
			//
			// initialize the view state			
			_appProxy.viewState = ApplicationProxy.LOGIN_STATE;	
		}

		/**
		 * List all notifications this Mediator is interested in.
		 * 
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array 
		{
			
			return [ 	
						ApplicationProxy.VIEW_STATE_CHANGED
					];
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
				case ApplicationProxy.VIEW_STATE_CHANGED:
					changeViewState();
				break;
				default:

			}
		}	

		/**
		 * Handles the applications view state based on the workflow state defined in Application Proxy
		 */	
		private function changeViewState():void
		{
			var child: Container;
			
			switch (_appProxy.viewState) 
			{
				case ApplicationProxy.LOGIN_STATE:
					child = app.login;
				break;
				case ApplicationProxy.LOGIN_ERROR_STATE:
					showError();
					child = app.login;
				break;
				case ApplicationProxy.LOGGED_IN_STATE:
					child = app.loggedIn;
				break;
				default:
					child = app.login;
			}			
			
			app.appView.selectedChild = child;
		}

		/**
		 * Shows an error effect on app
		 * @param message
		 */		
	   private function showError():void
	   {
	   		app.faultEffect.end();
	   		app.faultEffect.play();	   		
	   		//
			// set the view state back to the login state
			_appProxy.viewState = ApplicationProxy.LOGIN_STATE;

	   }
		
		/**
		 * Cast the viewComponent to its actual type.
		 * 
		 * @return app the viewComponent cast to Login
		 */
		protected function get app(): Login
		{
			return viewComponent as Login;
		}
	}
}