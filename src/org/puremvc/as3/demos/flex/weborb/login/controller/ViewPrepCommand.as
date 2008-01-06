/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.controller
{	
	import org.puremvc.as3.demos.flex.weborb.login.model.ApplicationProxy;
	import org.puremvc.as3.demos.flex.weborb.login.view.ApplicationMediator;
	import org.puremvc.interfaces.*;
	import org.puremvc.patterns.command.*;
	import org.puremvc.patterns.observer.*;

	public class ViewPrepCommand extends SimpleCommand
	{
		/**
		 * Register the Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		override public function execute(note: INotification) :void	
		{
			facade.registerMediator( new ApplicationMediator(note.getBody()));
			
			var appProxy: ApplicationProxy = facade.retrieveProxy(ApplicationProxy.NAME) as ApplicationProxy;
			appProxy.workflowState = ApplicationProxy.VIEWING_LOGIN_SCREEN;			
		}		
	}
}