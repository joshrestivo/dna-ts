angular.module('app').controller('locationController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
	$scope.Init = function(){
    	$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
    	getData();
      };
    
    var getData = function(){
    	$http.get(SERVICE_BASE_URL+'/admin/locations ',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
    		.success(function (result) {
	            if (result.success) {
	            	$scope.locations = result.data;
	            	$scope.TotalItems = $scope.locations.length;
	            } else {
            		processCommonExeption(result.data, ngDialog);
                }
            })
            .error(function (error, status){
            	showErrorDialog(ngDialog,SERVER_ERROR_MSG);
  			}); 
    };
    
    $scope.addNewLocation = function(){
		gotoLocationDetailPage();	
    };
    
    $scope.editLocation = function(location){
		sessionStorage.setItem("location", JSON.stringify(location));
		gotoLocationDetailPage();
    };
    
    $scope.deleteLocation=function(location){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete location: ' + location.Name + '?"}'
		})
		.then(function (value) {
           $http.get(SERVICE_BASE_URL+'/admin/location/'+location.id+'/del  ',{ withCredentials: true ,headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)}})
       			.success(function (result) {
		            if (result.success) {
		            	getData();
		            } else {
                		processCommonExeption(result.data, ngDialog);
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