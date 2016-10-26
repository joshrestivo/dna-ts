angular.module('app').controller('clientResourceController',  ['$scope', '$http', function ($scope, $http) {    
   
   	
   	$http.get(SERVICE_BASE_URL + '/resources')
	        .success(function (result) {	                
	            if (result.success) {
	            	alert(JSON.stringify(result));
	            }
	        })
	        .error(function (error, status){	            	
		        alert(error);
			}); 
	  			
   	$scope.resources = [
   		{ id:"1", name:"New York", is_default:"true"},
   		{ id:"2", name:"England", is_default:"false"},
   		{ id:"3", name:"VN", is_default:"false"},
   		{ id:"4", name:"China", is_default:"false"},
   		{ id:"5", name:"Singapore", is_default:"false"},
   	];
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
   	
 	$scope.updateResource = function (event, id) {
 		$('li[class*="active"]').removeClass("active");
	    angular.element(event.currentTarget).parent().addClass("active");
	};
   	   	
    $(".nav li.tab_client_resources").addClass("active");       
}]);