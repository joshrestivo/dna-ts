angular.module('app').controller('buildingController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
	$scope.Init = function(){
    	$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
	    $http.get(SERVICE_BASE_URL+'/admin/locations ',{ withCredentials: true, headers: {'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')} }).success(function (result) {
            if (result.success) {
            	$scope.locations = result.data;
            	if( $scope.locations.length>0){
            		$scope.location_id= $scope.locations[0].id;
            	}
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
	  			if($scope.location_id){
	  				getData($scope.location_id);			
	  			}
      };
    
    var getData = function(location_id){
    	$http.get(SERVICE_BASE_URL+'/admin/location/'+location_id+'/buidlings ',{ withCredentials: true, headers: {'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')} }).success(function (result) {
            if (result.success) {
            	$scope.buidlings = result.data;
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
    
    $scope.changeLocation=function(location_id){
    	getData(locationId);
    };
    
    $scope.addNewBuilding = function(){
    		sessionStorage.setItem("locationId",$scope.location_id);
    		location.href="/main/building/building-detail.html";	
    };
    
    $scope.editBuilding = function(building){
    		sessionStorage.setItem("building", JSON.stringify(building));
			window.location.href=("/main/building/building-detail.html");
    };
    
    $scope.deleteBuilding=function(building){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete building: ' + building.name + '?"}'
		})
		.then(function (value) {
           $http.get(SERVICE_BASE_URL+'/admin/location/'+building.location_id+'/building/'+buiding.id+'/del  ',{ withCredentials: true ,headers: {'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')}}).success(function (result) {
			            if (result.success) {
			            getData(building.location_id);
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
   	$(".nav li.tab_building").addClass("active"); 
}]);