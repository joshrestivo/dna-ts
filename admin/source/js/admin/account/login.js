angular.module('app').controller('loginController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.Model = {};
    
    $("#user_name").focus();
   	$scope.authenticate = function () {   
   		if ($scope.login.$valid) {   			
		    $http.post(SERVICE_BASE_URL + '/admin/login', $scope.Model,{ withCredentials: true })
	            .success(function (result) {	                
	                if (result.success) {	      	                	 
        	          	createCookie(AUTH_COOKIE_NAME, result.data.access_token, 7);   
        	          	createCookie(USERNAME_LOGIN_COOKIE, result.data.name, 7);     	          	
	                	var return_url = getUrlParameter("return_url");    
	                    if (return_url != ""){	                    	
	                    	window.location.href = return_url;
	                    } else {
	                    	window.location.href = "/";
	                    }
	                } else {
	                	if(result.data == "INCORRECT") {                	
	                		showErrorDialog(ngDialog, "Invalid login credential") ;
	                	} else {                  	  	
	                		processCommonExeption(result.data, ngDialog);
	                	}
	                	
	                    $("#user_name").focus();
	                }
	            })
	            .error(function (error, status){	            	
			        processCommonExeption(SERVER_ERROR_MSG, ngDialog);
	  			}); 
   		}
    };
}]);