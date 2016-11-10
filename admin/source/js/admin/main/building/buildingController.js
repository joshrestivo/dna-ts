angular.module('app').controller('buildingController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
	$scope.Init = function(){
		$scope.location_id=0;
    	$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
	    $http.get(SERVICE_BASE_URL+'/admin/locations ',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
	    	.success(function (result) {
	            if (result.success) {
	            	$scope.locations = result.data;
	            	$scope.location_id=$scope.locations[0].id;
	            	getData($scope.location_id);
	            } else {
            		processCommonExeption(result.data, ngDialog);
                }
            })
            .error(function (error, status){
            	showErrorDialog(ngDialog,SERVER_ERROR_MSG);
  			});
	};
  		
    var getData = function(location_id){
    	$http.get(SERVICE_BASE_URL+'/admin/location/'+location_id+'/buildings ',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
    		.success(function (result) {
	            if (result.success) {
	            	$scope.buildings = result.data;
	            	$scope.TotalItems = $scope.buildings.length;
	            } else {
            		processCommonExeption(result.data, ngDialog);
                }
            })
            .error(function (error, status){
            	showErrorDialog(ngDialog,SERVER_ERROR_MSG);
  			}); 
    };
    
    $scope.changeLocation=function(location_id){
    	getData(location_id);
    };
    
    $scope.addNewBuilding = function(){
		sessionStorage.setItem("locationId",$scope.location_id);
		gotoBuildingDetailPage();
    };
    
    $scope.editBuilding = function(building){
		sessionStorage.setItem("building", JSON.stringify(building));
		gotoBuildingDetailPage();
    };
    
    $scope.deleteBuilding=function(building){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete building: ' + building.name + '?"}'
		})
		.then(function (value) {
           $http.get(SERVICE_BASE_URL+'/admin/location/'+building.location_id+'/building/'+building.id+'/del  ',{ withCredentials: true ,headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)}})
           		.success(function (result) {
		            if (result.success) {
		            	getData(building.location_id);
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
   	$(".nav li.tab_building").addClass("active"); 
}]);