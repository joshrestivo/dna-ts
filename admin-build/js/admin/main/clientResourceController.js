angular.module('app').controller('clientResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {    
	  	
   	$http.get(SERVICE_BASE_URL + '/resources', { withCredentials: true })
	        .success(function (result) {	                
	            if (result.success) {	     	            	
	            	$scope.resources = result.data;
	            	$scope.keyResources = result.data[0].details;
	            	sessionStorage.setItem("allResource", JSON.stringify(result.data));	            	
	            }
	        })
	        .error(function (error, status){	            	
		        processCommonExeption(error, ngDialog);
			}); 	  			   	
   	
 	$scope.createUpdateResource = function (resource) {
 		if (resource != null) { 	
 			sessionStorage.setItem("resource", JSON.stringify(resource)); 			
 		}
 		
 		window.location.href = ("/main/update-client-resource.html"); 	
	};
	
	$scope.createUpdateKeyResource = function (keyResource) { 	
		if(keyResource != null) {			
			sessionStorage.setItem("keyResource", JSON.stringify(keyResource));
		} 
 		window.location.href = ("/main/update-key-resource.html"); 	 		 		
	};
	
	$scope.reloadResourceDetail = function(resource, event) {
		$scope.keyResources = resource.details;
		
		$('li[class*="active"]').removeClass("active");
		angular.element(event.currentTarget).parent().addClass("active");
	};
	
    $(".nav li.tab_client_resources").addClass("active");       
}]);