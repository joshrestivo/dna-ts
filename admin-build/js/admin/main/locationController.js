angular.module('app').controller('locationController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.Init = function(){
    	getData();
    };
    
    var getData = function(){
    	$http.get(SERVICE_BASE_URL+'/locations ',{ withCredentials: true }).success(function (result) {
            if (result.Success) {
                $scope.locations = result.Data;
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
    
    $scope.addNewLocation = function(){
    		location.href="/main/location-detail.html";	
    };
    
    $scope.editLocation = function(location){
    		sessionStorage.setItem("location", JSON.stringify(location));
			location.href=location.orgrin +"main/location-detail.html";
    };
    
    $scope.deleteLocation=function(location){
    		$http.get(SERVICE_BASE_URL+'/location/'+location.id+'/del  ',{ withCredentials: true }).success(function (result) {
            if (result.Success) {
                alert("OK");
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
    
    $scope.maxSize = 5; 
    $scope.itemPerPage = 20;
    $scope.TotalItems = 1;
   	$scope.currentPage = 1;
   	
   	
   	
   	//active tab
   	$(".nav li.tab_locations").addClass("active"); 
}]);