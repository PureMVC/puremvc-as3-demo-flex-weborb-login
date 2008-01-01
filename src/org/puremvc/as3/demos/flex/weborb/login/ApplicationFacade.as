/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login
{
	import org.puremvc.as3.demos.flex.weborb.login.controller.ApplicationStartupCommand;
	import org.puremvc.as3.demos.flex.weborb.login.controller.LoginCommand;
	import org.puremvc.interfaces.*;
	import org.puremvc.patterns.facade.*;
	import org.puremvc.patterns.observer.Notification;
	import org.puremvc.patterns.proxy.*;

	public class ApplicationFacade extends Facade
	{
		/**
		 * Notification name constants
		 */
		public static const APP_STARTUP: String = "appStartup";
		public static const APP_STATE: String = "changeAppState";

		public static const LOGIN: String = "login";
		public static const LOGIN_FAILED: String = "loginFailed";
		public static const LOGIN_SUCCES: String = "loginSucces";		
		
				
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance(): ApplicationFacade
		{
			if (instance == null) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}

		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController() : void 
		{
			super.initializeController();			
			registerCommand( APP_STARTUP, ApplicationStartupCommand);
			registerCommand( LOGIN, LoginCommand );
		}		

		public function startup(app:DemoAS3FlexWebORBLogin):void
		{
			this.notifyObservers (new Notification(ApplicationFacade.APP_STARTUP, app));
		}
 	}
}