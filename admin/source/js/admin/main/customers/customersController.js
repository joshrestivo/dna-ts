angular.module('app').controller('bulletinsController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {    	  			
   	
  	$scope.Init = function () {
  		$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
    	
    	getCustomers();
	};  		
    
	$scope.addNewCustomer = function(){
		location.href="/main/customers/customer-detail.html";	
    };
    
    $scope.editCustomer = function(customer){
		sessionStorage.setItem("customer", JSON.stringify(customer));		
		location.href="/main/customers/customer-detail.html";
    };
    
    $scope.deleteCustomer =function(customer){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete customer: ' + customer.name + '?"}'
		})
		.then(function (value) {
        	$http.get(SERVICE_BASE_URL + '/admin/customer/' + customer.id + '/del',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
            .success(function (result) {	             	              
                if (result.success) {	    
    	          	getCustomers();          	    	          	
                } else {       
            		processCommonExeption(result.data, ngDialog);              	                    
                }
            })
            .error(function (error, status){	            	
		        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
  			}); 	
        }, function (value) {});
	};
  
    $(".nav li.tab_customers").addClass("active");       
    
    var getCustomers = function() {
    	$http.get(SERVICE_BASE_URL + '/admin/customers',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
            .success(function (result) {	             	              
                if (result.success) {	     
    	          	$scope.customers = result.data;    
    	          	$scope.TotalItems = $scope.customers.length;	          	    	          	
                } else {       
            		processCommonExeption(result.data, ngDialog);              	                    
                }
            })
            .error(function (error, status){	            	
		        processCommonExeption(SERVER_ERROR_MSG, ngDialog);       
  			}); 	
    };
}]);