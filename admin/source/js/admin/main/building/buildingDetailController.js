angular.module('app').controller('buildingDetailController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.building = {
    	id:0,
    	location_id:0
    };	
	var editBuilding = sessionStorage.getItem("building");
	sessionStorage.removeItem("building");
	
    $scope.Init = function(){
    	//check add new or edit
	  	if (typeof editBuilding !== 'undefined' && editBuilding == null) {		
	  		var location_id = sessionStorage.getItem("locationId");
	  		$scope.building.location_id=location_id;
			$scope.IsUpdate = false;
		} else {
			$scope.building = JSON.parse(editBuilding);
			$scope.IsUpdate = true;
		}
    };

   $scope.cancel=function(){
   		window.location.href = "/main/building/building.html";
   };
   	
   $scope.save = function(){
	   	if($scope.buildingDetail.$valid)
	   	{
	   		  var formData = new FormData();
	               formData.append('id',$scope.building.id);
	               formData.append('name',$scope.building.name);
	               formData.append('address',$scope.building.address);
	               formData.append('zipcode',$scope.building.zipcode);
	               formData.append('image',$scope.file);
	               
   			$http.post(SERVICE_BASE_URL+'/admin/location/'+$scope.building.location_id+'/building/save',formData,{
   				withCredentials: true,
   				transformRequest: angular.identity,
	   			headers: {
		            		'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN'),
		                	'Content-Type': undefined
		            		}
	            }).success(function (result) {
	            if (result.success) {
	            	if($scope.IsUpdate){
	            		showInfoDialog(ngDialog,"Building updated.");
	            	}else{
	            		showInfoDialog(ngDialog,"Building added.");
	            	}
	        	}else {
	                		processCommonExeption(result.data, ngDialog);
	        	}
	         })
	         .error(function (error, status){
				       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
  			}); 
   		}
   };
   	//active tab
   	$(".nav li.tab_building").addClass("active"); 
}]);