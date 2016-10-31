angular.module('app').controller('locationDetailController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.Init = function(){
    	//load all resource
    	$http.get(SERVICE_BASE_URL+'/resources ',{ withCredentials: true }).success(function (result) {
            if (result.Success) {
                $scope.resources = result.Data;
            }else {
	                	if(result.data == "INVALID_SESSION") {                	
	                		$scope.errorMessage  = "Invalid login credantial";
	                	} else {                  	  	
	                		processCommonExeption(result.data, $scope);
	                	}
	                }
	            })
	            .error(function (error, status){
			        $scope.errorMessage = SERVER_ERROR_MSG; 
	  			}); 
    };
    
   $scope.cancel=function(){
   		location.href = "/main/location.html";
   };
   	
   $scope.save = function(){
   	
   		$http.get(SERVICE_BASE_URL+'/resources ',{ withCredentials: true }).success(function (result) {
            if (result.Success) {
                $scope.resources = result.Data;
            }else {
	                	if(result.data == "INVALID_SESSION") {                	
	                		$scope.errorMessage  = "Invalid login credantial";
	                	} else {                  	  	
	                		processCommonExeption(result.data, $scope);
	                	}
	                }
	            })
	            .error(function (error, status){
			        $scope.errorMessage = SERVER_ERROR_MSG; 
	  			}); 
   };
   	//active tab
   	$(".nav li.tab_locations").addClass("active"); 
}]);