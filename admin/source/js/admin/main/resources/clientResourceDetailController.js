angular.module('app').controller('updateClientResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {	
	
	var resource = sessionStorage.getItem("resource");
	sessionStorage.removeItem("resource");
	
	$scope.Init = function () {
		$scope.Model = {};	
		$scope.IsUpdate = false;
		if (typeof resource !== 'undefined' && resource == null) {		
			$scope.IsUpdate = false;
			$scope.Model.id = 0;
			$scope.Model.is_default = false;
		} else {
			resource = JSON.parse(resource);			
			$scope.IsUpdate = true;
			$scope.Model.id = resource.id;
			$scope.Model.name = resource.name;
			$scope.Model.is_default = resource.is_default;
		}
	};
		
	$scope.createUpdateResource = function () {
		if($scope.updateClientResource.$valid) {
			$http.post(SERVICE_BASE_URL + '/admin/resource/save',$scope.Model,{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
		        .success(function (result) {	                
		            if (result.success) {	      
			          	gotoClientResourcePage();
		            } else {                	   		                            	  
                		processCommonExeption(result.data, ngDialog);                	   	  	
		            }
		        })
		        .error(function (error, status){	            	
			        processCommonExeption(SERVER_ERROR_MSG, ngDialog);
				}); 	
		} 		  
	};
		
    $(".nav li.tab_client_resources").addClass("active");       
}]);