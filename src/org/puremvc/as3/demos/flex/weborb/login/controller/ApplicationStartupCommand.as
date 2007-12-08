/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.controller
{
	import org.puremvc.interfaces.*;
	import org.puremvc.patterns.command.*;

	public class ApplicationStartupCommand extends MacroCommand
	{		
		/**
		 * Register the Proxies Commands.
		 */
		override protected function initializeMacroCommand() :void
		{
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}		
	}
}