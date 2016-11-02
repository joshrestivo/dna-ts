angular.module('app').controller('bulletinsController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {    	  			
  	var bulletins = [
   		{ Name:"Alert Type1", City:"New York"},
   		{ Name:"Alert Type2", City:"New York"},
   		{ Name:"Alert Type3", City:"New York"},
   		{ Name:"Alert Type4", City:"New York"},
   		{ Name:"Alert Type5", City:"New York"},
   		{ Name:"Alert Type6", City:"New York"},
   		{ Name:"Alert Type7", City:"New York"},
   		{ Name:"Alert Type8", City:"New York"},
   		{ Name:"Alert Type9", City:"New York"},
   		{ Name:"Alert Type10", City:"New York"},	
   		{ Name:"Alert Type11", City:"New York"},
   		{ Name:"Alert Type12", City:"New York"},
   		{ Name:"Alert Type13", City:"New York"},
   		{ Name:"Alert Type14", City:"New York"},
   		{ Name:"Alert Type15", City:"New York"},
   		{ Name:"Alert Type16", City:"New York"},
   		{ Name:"Alert Type17", City:"New York"},
   		{ Name:"Alert Type18", City:"New York"},
   		{ Name:"Alert Type19", City:"New York"},
   		{ Name:"Alert Type20", City:"New York"},		
   		{ Name:"Alert Type21", City:"New York"},
   		{ Name:"Alert Type22", City:"New York"},
   		{ Name:"Alert Type23", City:"New York"},
   		{ Name:"Alert Type24", City:"New York"},
   		{ Name:"Alert Type25", City:"New York"},
   		{ Name:"Alert Type26", City:"New York"},
   		{ Name:"Alert Type27", City:"New York"},
   		{ Name:"Alert Type28", City:"New York"},
   		{ Name:"Alert Type29", City:"New York"},
   		{ Name:"Alert Type30", City:"New York"},		
   		{ Name:"Alert Type31", City:"New York"},
   		{ Name:"Alert Type32", City:"New York"},
   		{ Name:"Alert Type33", City:"New York"},
   		{ Name:"Alert Type34", City:"New York"},
   		{ Name:"Alert Type35", City:"New York"},
   		{ Name:"Alert Type36", City:"New York"},
   		{ Name:"Alert Type37", City:"New York"},
   		{ Name:"Alert Type38", City:"New York"},
   		{ Name:"Alert Type39", City:"New York"},
   		{ Name:"Alert Type40", City:"New York"},	
   		{ Name:"Alert Type41", City:"New York"},
   		{ Name:"Alert Type42", City:"New York"},
   		{ Name:"Alert Type43", City:"New York"},
   		{ Name:"Alert Type44", City:"New York"},
   		{ Name:"Alert Type45", City:"New York"},
   		{ Name:"Alert Type46", City:"New York"},
   		{ Name:"Alert Type47", City:"New York"},
   		{ Name:"Alert Type48", City:"New York"},
   		{ Name:"Alert Type49", City:"New York"},
   		{ Name:"Alert Type50", City:"New York"},		
   	];
   	
   	$scope.bulletinsFiltered = [];
   	$scope.currentPage = 1;
    $scope.itemPerPage = ITEM_PER_PAGE;
    $scope.maxSize = PAGE_MAX_SIZE;
   	$scope.TotalItems = bulletins.length;
   	
   	$scope.bulletins = bulletins;
   	
  	$scope.Init = function () {
		$http.get(SERVICE_BASE_URL + '/admin/locations',{ withCredentials: true, headers: {'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')} })
	            .success(function (result) {	             	              
	                if (result.success) {	     
	    	          	$scope.locations = result.data;
	                } else {       
                		processCommonExeption(result.data, ngDialog);              	                    
	                }
	            })
	            .error(function (error, status){	            	
			        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
	  			}); 	
	};  		
	
	$scope.test = function(city) {
		alert(city);
	};
  
	$scope.$watch('currentPage + itemPerPage', function() {
		var begin = (($scope.currentPage - 1) * $scope.itemPerPage)
		, end = begin + $scope.itemPerPage;
		
		$scope.bulletinsFiltered = $scope.bulletins.slice(begin, end);
  	});
  
    $(".nav li.tab_bulletins").addClass("active");       
}]);