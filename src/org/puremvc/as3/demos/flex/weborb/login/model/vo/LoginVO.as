/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.weborb.login.model.vo
{

	[RemoteClass(alias="org.puremvc.as3.demos.flex.weborb.login.vo.LoginVO")]	
	
   	[Bindable]
	public class LoginVO
	{
		public var username: String;
		public var password: String;
		public var loginDate: Date;
	}	
}