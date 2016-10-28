angular.module('app').controller('clientResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {    
      	
   	$http.get(SERVICE_BASE_URL + '/resources', { withCredentials: true })
	        .success(function (result) {	                
	            if (result.success) {
	            	$scope.resources = result.data;
	            	$scope.resourceDetails = result.data.details;
	            }
	        })
	        .error(function (error, status){	            	
		        processCommonExeption(error, ngDialog);
			}); 	  			   	
   	
 	$scope.createUpdateResource = function (event, resource) {
 		if (event != null) {
 			sessionStorage.setItem("resource", JSON.stringify(resource));
 		}
 		
 		window.location.href = ("/main/update_client_resource.html"); 	
 		
 		/*if (event != null) {
 			$('li[class*="active"]').removeClass("active");
 			angular.element(event.currentTarget).parent().addClass("active");
 		}	 */   
	};
	
    $(".nav li.tab_client_resources").addClass("active");       
}]);