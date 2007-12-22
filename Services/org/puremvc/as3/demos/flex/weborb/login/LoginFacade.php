<?php
/* 
 PureMVC Flex/WebORB Demo – Login 
 Copyright (c) 2007 Jens Krause <jens.krause@puremvc.org> <www.websector.de>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

require_once("vo/LoginVO.php");
/*
	The class named LoginFacade is acting as a Facade using the future version of PureMVC for PHP.
	It checks the username and its password to return an instance of LoginVO.
*/
class LoginFacade
{
	
    public function getUser(LoginVO $loginVO)
    {	      	
		if ($loginVO->username == "admin" 
			&& $loginVO->password == "admin")
		{
			$adminVO = new LoginVO(); 
			$adminVO->username = $loginVO->username;
			$adminVO->password = $loginVO->password;
			return $adminVO;
		}
		else
		{
			throw new Exception("Invalid username or password, please try it again.");			
		}

    }
}

?>
