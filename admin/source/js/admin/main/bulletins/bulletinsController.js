angular.module('app').controller('bulletinsController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {    	  			
   	
  	$scope.Init = function () {
  		$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
    	
    	getLocations();
	};  		
	
	$scope.changeLocation=function(locationId){
		$scope.locationId= locationId;
    	getBulletins(locationId);
    };
    
	$scope.addNewBulletin = function(){
		sessionStorage.setItem("locationId",$scope.locationId);
		location.href="/main/bulletins/bulletin-detail.html";	
    };
    
    $scope.editBulletin = function(bulletin){
		sessionStorage.setItem("bulletin", JSON.stringify(bulletin));
		sessionStorage.setItem("locationId",$scope.locationId);
		location.href="/main/bulletins/bulletin-detail.html";
    };
    
    $scope.deleteBulletin=function(bulletin){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete building: ' + bulletin.title + '?"}'
		})
		.then(function (value) {
        	$http.get(SERVICE_BASE_URL + '/admin/location/' + $scope.locationId + '/bulletin/' + bulletin.id + '/del',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
            .success(function (result) {	             	              
                if (result.success) {	    
    	          	getBulletins($scope.locationId);          	    	          	
                } else {       
            		processCommonExeption(result.data, ngDialog);              	                    
                }
            })
            .error(function (error, status){	            	
		        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
  			}); 	
        }, function (value) {});
	};
  
    $(".nav li.tab_bulletins").addClass("active");   
    
    var getLocations = function() {
    	$http.get(SERVICE_BASE_URL + '/admin/locations',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
            .success(function (result) {	             	              
                if (result.success) {	     
    	          	$scope.locations = result.data;
    	          	if( $scope.locations.length>0){
            			$scope.locationId= $scope.locations[0].id;
            			getBulletins($scope.locations[0].id);
            		}
                } else {       
            		processCommonExeption(result.data, ngDialog);              	                    
                }
            })
            .error(function (error, status){	            	
		        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
  			}); 	
    };    
    
    var getBulletins = function(locationId) {
    	$http.get(SERVICE_BASE_URL + '/admin/location/' + locationId + '/bulletins',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
            .success(function (result) {	             	              
                if (result.success) {	     
    	          	$scope.bulletins = result.data;    
    	          	$scope.TotalItems = $scope.bulletins.length;	          	    	          	
                } else {       
            		processCommonExeption(result.data, ngDialog);              	                    
                }
            })
            .error(function (error, status){	            	
		        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
  			}); 	
    };
}]);