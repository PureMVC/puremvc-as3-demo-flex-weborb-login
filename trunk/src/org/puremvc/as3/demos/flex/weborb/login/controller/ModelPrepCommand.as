/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.controller
{
	
	import org.puremvc.as3.demos.flex.weborb.login.model.ApplicationProxy;
	import org.puremvc.as3.demos.flex.weborb.login.model.LoginProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;


	public class ModelPrepCommand extends SimpleCommand
	{
		/**
		 * Register the Proxies.
		 */
		override public function execute( note:INotification ) :void	
		{			
			facade.registerProxy(new LoginProxy());	
			facade.registerProxy(new ApplicationProxy());	
		}
	}
}