angular.module('app').controller('clientResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {    
	  	
   	$http.get(SERVICE_BASE_URL + '/admin/resources', { withCredentials: true })
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
 		
 		window.location.href = ("/main/resources/update-client-resource.html"); 	
	};
	
	$scope.createUpdateKeyResource = function (keyResourceUniqueName) { 	
		if(keyResourceUniqueName != null) {			
			sessionStorage.setItem("keyResourceUniqueName", keyResourceUniqueName);
		} 
 		window.location.href = ("/main/resources/update-key-resource.html"); 	 		 		
	};
	
	$scope.deleteKeyResource = function(keyResourceUniqueName) {
		ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete ' + keyResourceUniqueName + '?"}'
		})
		.then(function (value) {
            $http.post(SERVICE_BASE_URL + '/admin/resource/key/del', {"unique_name": keyResourceUniqueName} ,{ withCredentials: true })
	        .success(function (result) {	                
	            if (result.success) {	      
		          	window.location.href = "/main/resources/client-resources.html";
	            } else {                	              	  	
	        		processCommonExeption(result.data, $scope);                	              	                    
	            }
	        })
	        .error(function (error, status){	            	
		        processCommonExeption(SERVER_ERROR_MSG, ngDialog);
			}); 	
        }, function (value) {
            
        });
	};
	
	$scope.reloadResourceDetail = function(resource, event) {
		$scope.keyResources = resource.details;
		
		$('.list-resource li[class*="active"]').removeClass("active");
		angular.element(event.currentTarget).parent().addClass("active");
	};
	
    $(".nav li.tab_client_resources").addClass("active");       
}]);