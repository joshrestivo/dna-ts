angular.module('app').controller('clientResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {    
	$scope.keyResourcesFiltered = [];
   	$scope.currentPage = 1;
    $scope.itemPerPage = ITEM_PER_PAGE;
    $scope.maxSize = PAGE_MAX_SIZE;   	
   	
   	$http.get(SERVICE_BASE_URL + '/admin/resources', { withCredentials: true })
	        .success(function (result) {	                
	            if (result.success) {	     	            	
	            	$scope.resources = result.data;	            	
	            	$scope.keyResources = result.data[0].details;
	            	$scope.TotalItems = result.data[0].details.length;
	            	sessionStorage.setItem("allResource", JSON.stringify(result.data));	    
	            	
	            	updatePaginationUI();   	
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
		updatePaginationUI();
	
		$('.list-resource li[class*="active"]').removeClass("active");
		angular.element(event.currentTarget).parent().addClass("active");
	};	
	
	var updatePaginationUI = function(){
		$scope.$watch('currentPage + itemPerPage', function() {
			var begin = (($scope.currentPage - 1) * $scope.itemPerPage)
			, end = begin + $scope.itemPerPage;
			
			$scope.keyResourcesFiltered = $scope.keyResources.slice(begin, end);
		});  
	};
	
    $(".nav li.tab_client_resources").addClass("active");       
}]);