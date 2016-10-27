angular.module('app').controller('clientResourceController',  ['$scope', '$http', function ($scope, $http) {    
      	
   	$http.get(SERVICE_BASE_URL + '/resources', { withCredentials: true })
	        .success(function (result) {	                
	            if (result.success) {
	            	alert(JSON.stringify(result));
	            	$scope.resources = result.data;
	            }
	        })
	        .error(function (error, status){	            	
		        alert(error);
			}); 
	  			   	
	$scope.resourceDetails = [
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"},
		{ unique_name:"unique_name1", display_text:"New York"}
   	];
   	
 	$scope.createUpdateResource = function (event, id) {
 		alert(id); 	
 		$http.post(SERVICE_BASE_URL + '/resource/save',{"id":"0", "name":"Ha Noi", "is_default":"true"},{ withCredentials: true })
            .success(function (result) {	                
                if (result.success) {	      
    	          	alert(JSON.stringify(result));
                } else {                	              	  	
            		processCommonExeption(result.data, $scope);                	              	                    
                }
            })
            .error(function (error, status){	            	
		        $scope.errorMessage = SERVER_ERROR_MSG; 
  			}); 	
 		if (event != null) {
 			$('li[class*="active"]').removeClass("active");
 			angular.element(event.currentTarget).parent().addClass("active");
 		}	    
	};
	
    $(".nav li.tab_client_resources").addClass("active");       
}]);