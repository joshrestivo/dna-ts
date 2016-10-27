angular.module('app').controller('updateClientResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {
	
	$scope.Model = {};	
	var resource = sessionStorage.getItem("resource");
	sessionStorage.removeItem("resource");
	
	$scope.Init = function () {
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
		
	$scope.createUPdateResource = function (event, resource) {
		if($scope.updateClientResource.$valid) {
			$http.post(SERVICE_BASE_URL + '/resource/save',$scope.Model,{ withCredentials: true })
            .success(function (result) {	                
                if (result.success) {	      
    	          	window.location.href = "/main/client_resources.html";
                } else {                	              	  	
            		processCommonExeption(result.data, $scope);                	              	                    
                }
            })
            .error(function (error, status){	            	
		        $scope.errorMessage = SERVER_ERROR_MSG; 
  			}); 	
		} 		  
	};
		
    $(".nav li.tab_client_resources").addClass("active");       
}]);