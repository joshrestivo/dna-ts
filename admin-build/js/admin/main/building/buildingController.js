angular.module('app').controller('locationController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
	$scope.Init = function(){
    	$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
    	getData();
      };
    
    var getData = function(){
    	$http.get(SERVICE_BASE_URL+'/admin/locations ',{ withCredentials: true }).success(function (result) {
            if (result.success) {
            	$scope.locations = result.data;
            	$scope.TotalItems = $scope.locations.length;
            }else {
	                	if(result.data == "INVALID_SESSION") {                	
	                		showErrorDialog(ngDialog,"Invalid login credantial");
	                	} else {                  	  	
	                		processCommonExeption(result.data, ngDialog);
	                	}
	                }
	            })
	            .error(function (error, status){
	            	showErrorDialog(ngDialog,SERVER_ERROR_MSG);
	  			}); 
    };
    
    $scope.addNewLocation = function(){
    		location.href="/main/location/location-detail.html";	
    };
    
    $scope.editLocation = function(location){
    		sessionStorage.setItem("location", JSON.stringify(location));
			window.location.href=("/main/location/location-detail.html");
    };
    
    $scope.deleteLocation=function(location){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete location: ' + location.Name + '?"}'
		})
		.then(function (value) {
           $http.get(SERVICE_BASE_URL+'/admin/location/'+location.id+'/del  ',{ withCredentials: true }).success(function (result) {
			            if (result.success) {
			            getData();
			            }else {
				                	if(result.data == "INVALID_SESSION") {                	
				                		showErrorDialog(ngDialog,"Invalid login credantial");
				                	} else {                  	  	
				                		processCommonExeption(result.data, ngDialog);
				                	}
				                }
				            })
				            .error(function (error, status){
						       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
				  			}); 
	                    
        }, function (value) {});
	};
	
    //active tab
   	$(".nav li.tab_locations").addClass("active"); 
}]);