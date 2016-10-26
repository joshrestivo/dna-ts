var app = angular.module("login", ['ui.bootstrap']);
app.controller('loginController', function ($scope, $http) {
    $scope.Model = {};
    
    $("#user_name").focus();
   	$scope.authenticate = function () {   
   		if ($scope.login.$valid) {
   			showLoadingImage();
		    $http.post(SERVICE_BASE_URL + '/login', $scope.Model)
	            .success(function (result) {
	                hideLoading();
	                if (result.success) {
	                	createCookie("TOWNSQUARE_ADMIN", "test", 7);
	                	var return_url = getUrlParameter("return_url");                	
	                    if (return_url != ""){	                    	
	                    	window.location.href = return_url;
	                    }
	                } else {
	                	if(result.data == "INCORRECT") {                	
	                		$scope.errorMessage  = "Invalid login credantial";
	                	} else {                  	  	
	                		processCommonExeption(result.data, $scope);
	                	}
	                	
	                    $("#user_name").focus();
	                }
	            })
	            .error(function (error, status){
	            	hideLoading();
			        $scope.errorMessage = SERVER_ERROR_MSG; 
	  			}); 
   		}
    };
});