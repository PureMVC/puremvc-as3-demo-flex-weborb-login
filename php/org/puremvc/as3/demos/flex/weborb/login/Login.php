<?php

require_once("vo/LoginVO.php");
	
class Login
{
	
    public function getUser(LoginVO $loginVO)
    {	      	
		if ($loginVO->username == "admin" && $loginVO->password == "admin")
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
