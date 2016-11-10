angular.module('app').controller('locationDetailController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.location = {
    	id:0,
    	city:"",
    	state:"",
    	has_upcomming_events:false,
    	has_request_service:false,
    	has_location_info:false,
    	has_street_alerts:false
    };	
	var editLocation = sessionStorage.getItem("location");
	sessionStorage.removeItem("location");
	
    $scope.Init = function(){
    	//load all resource
    	$http.get(SERVICE_BASE_URL+'/admin/resources ',{ withCredentials: true,headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
	    	.success(function (result) {
	            if (result.success) {
	                $scope.resources = result.data;
	            }else {
            		processCommonExeption(result.data, ngDialog);
                }
            })
	        .error(function (error, status){
	       		showErrorDialog(ngDialog,SERVER_ERROR_MSG);
			});
	  			
	  	//check add new or edit
	  	if (typeof editLocation !== 'undefined' && editLocation == null) {		
			$scope.IsUpdate = false;
			$scope.location.id = 0;
		} else {
			$scope.location = JSON.parse(editLocation);
			$scope.IsUpdate = true;
		}
    };

    $scope.$on('gmPlacesAutocomplete::placeChanged', function(){
   		var googleLocation =$scope.autocomplete.getPlace();
	    $.each(googleLocation.address_components,function(index,item) {
	   	if (item.types[0] == "locality") {
	                $scope.location.city= item.long_name;
	            }
	        if (item.types[0] == "administrative_area_level_1") {
	            $scope.location.state= item.long_name;
	        }
	         if (item.types[0] == "country") {
	            $scope.location.country= item.long_name;
	            $scope.location.country_code= item.short_name;
	        }
	   });
	   $scope.location.longitude= googleLocation.geometry.location.lng();
	   $scope.location.latitude= googleLocation.geometry.location.lat();
	   if($scope.location.city==""){
			$scope.location.city=$scope.location.state;
	   }
	   $scope.$apply();
  });

   $scope.cancel=function(){
   		gotoLocationPage();
   };
   	
   $scope.save = function(){
	   	if($scope.locationDetail.$valid){
	   		$http.post(SERVICE_BASE_URL+'/admin/location/save ', $scope.location, { withCredentials: true,headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
		   		.success(function (result) {
		            if (result.success) {
		            	gotoLocationPage();
		        	} else {
	            		processCommonExeption(result.data, ngDialog);
		        	}
		         })
		         .error(function (error, status){
				       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
	  			}); 
	   		}
   		};
   	//active tab
   	$(".nav li.tab_locations").addClass("active"); 
}]);