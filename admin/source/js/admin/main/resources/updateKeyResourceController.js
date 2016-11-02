angular.module('app').controller('addKeyResourceController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {
	
	$scope.Model = {};	
	$scope.IsUpdate = false;
	var allResource = JSON.parse(sessionStorage.getItem("allResource"));
	var keyResourceUniqueName = sessionStorage.getItem("keyResourceUniqueName");
	sessionStorage.removeItem("keyResourceUniqueName");		
	
	$scope.Init = function () {
		$scope.resources = allResource;		
				
		if (keyResourceUniqueName != null) {
			$scope.Model.unique_name = keyResourceUniqueName;
			var displayTextInit = new Array();		
			$.each(allResource, function (index, value) {
	  			keyResource = $.grep(allResource[index].details, function(e){ return e.unique_name == keyResourceUniqueName; });
	  			displayTextInit[allResource[index].id] = keyResource[0].display_text;
			});						
			$scope.Model.values = displayTextInit;	
			$scope.IsUpdate = true;					
			$('.unquie-name').prop('readonly', true);
		} else {
			$scope.Model.unique_name = "";
			$scope.IsUpdate = false;
		}
	};
		
	$scope.createUpdateKeyResource = function () {
		if($scope.addKeyResource.$valid) {
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
			data.values = JSON.stringify(values);
			
			$http.post(SERVICE_BASE_URL + '/admin/resource/key/add',JSON.stringify(data),{ withCredentials: true, headers: {'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')} })
	            .success(function (result) {	             	              
	                if (result.success) {	      
	    	          	window.location.href = "/main/resources/client-resources.html";
	                } else {       
	                	if(result.data == "VALUE_MISSING") {                	
	                		showErrorDialog(ngDialog, "VALUE_MISSING") ;
	                	} else {                  	  	
	                		processCommonExeption(result.data, ngDialog);
	                	}                	              	                    
	                }
	            })
	            .error(function (error, status){	            	
			        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
	  			}); 	
		}		
	};
		
    $(".nav li.tab_client_resources").addClass("active");       
}]);