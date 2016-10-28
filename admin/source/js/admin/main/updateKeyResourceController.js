angular.module('app').controller('addKeyResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {
	
	$scope.Model = {};	
	var allResource = JSON.parse(sessionStorage.getItem("allResource"));
	var keyResource = sessionStorage.getItem("keyResource");
	sessionStorage.removeItem("keyResource");	
	
	$scope.Init = function () {
		$scope.resources = allResource;		
		if (keyResource == null) {
			keyResource = $.grep(allResource, function(e){ return e.is_default == true; });						
		} 
	};
		
	$scope.createUpdateKeyResource = function () {
		if($scope.addKeyResource.$valid) {
			alert(JSON.stringify($scope.Model));
			
			var data = {};
			data.unique_name = $scope.Model.unique_name;
			
			var values = new Array();
			$.each($scope.Model.values, function (index, value) {
				var keyResource = {
					resource_id: index,
					display_text: value
				};  	
				values.push(keyResource);		
			});		
			data.values = values;
			
			$http.post(SERVICE_BASE_URL + '/resource/key/add',JSON.stringify(data),{ withCredentials: true })
            .success(function (result) {	             	              
                if (result.success) {	      
    	          	alert("Success");
                } else {       
                	alert("failed");  
            		processCommonExeption(result.data, ngDialog);                	              	                    
                }
            })
            .error(function (error, status){	            	
		        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
  			}); 	
		}
		
		
	};
		
    $(".nav li.tab_client_resources").addClass("active");       
}]);