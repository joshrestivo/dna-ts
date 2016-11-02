angular.module('app').controller('locationDetailController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.location = {
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
    	$http.get(SERVICE_BASE_URL+'/admin/resources ',{ withCredentials: true }).success(function (result) {
            if (result.success) {
                $scope.resources = result.data;
                
            }else {
	                  	if(result.data == "INVALID_SESSION") {           
	                		showErrorDialog(ngDialog,"Invalid login credantial");
	                	} else {                  	  	
	                		processCommonExeption(result.data, ngDialog);
	                	}
	                }
	            })
	            .error(function (error, status){
	            	processCommonExeption(error, ngDialog);
			       //showErrorDialog(ngDialog,SERVER_ERROR_MSG);
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
	    $.each(googleLocation.address_components,function(index,item){
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
   		window.location.href = "/main/location.html";
   };
   	
   $scope.save = function(){
   		var data = {
   			id:$scope.location.id,
   			name:$scope.location.name,
   			longitude:$scope.location.longitude,
   			latitude:$scope.location.latitude,
   			city:$scope.location.city,
   			state:$scope.location.state,
   			country_code:$scope.location.country_code,
   			street_alerts_rss_feed_url:$scope.location.street_alerts_rss_feed_url,
   			has_upcomming_events:$scope.location.has_upcomming_events,
   			has_request_service:$scope.location.has_request_service,
   			has_location_info:$scope.location.has_location_info,
   			has_street_alerts:$scope.location.has_street_alerts,
   			client_resource_id:$scope.location.resource.id,
   		};
   		alert(JSON.stringify(data));
   		$http.post(SERVICE_BASE_URL+'/admin/location/save ', data, { withCredentials: true })
   		.success(function (result) {
            if (result.success) {
               alert("OK");
        	}else {
                		processCommonExeption(result.data, ngDialog);
        	}
         })
         .error(function (error, status){
			       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
	  			}); 
   };
   	//active tab
   	$(".nav li.tab_locations").addClass("active"); 
}]);