angular.module('app').controller('customerDetailController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {	
	
	var customer = sessionStorage.getItem("customer");
	sessionStorage.removeItem("customer");	
	
	$scope.Init = function () {
		$scope.Model = { id: 0 };
		$scope.IsUpdate = false;
		if (typeof customer !== 'undefined' && customer == null) {		
			$scope.IsUpdate = false;
		} else {
			$scope.IsUpdate = true;
			customer = JSON.parse(customer);	
			$scope.Model.id = customer.id;
			$scope.Model.name = customer.name;
			$scope.Model.phone = parseInt(customer.phone);
			$scope.Model.address = customer.address;
			$scope.Model.email = customer.email;			
		}
	};
		
	$scope.createUpdateCustomer = function () {
		if($scope.updateCustomer.$valid) {						
			$http.post(SERVICE_BASE_URL + '/admin/customer/save',$scope.Model,{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
		        .success(function (result) {
					 if (result.success) {	      
				          	location.href="/main/customers/customers.html";
			            } else {    
			            	if(result.data == ErrorCode.EMAIL_EXISTED){
			            		showErrorDialog(ngDialog, ErrorMessage.CREATE_UPDATE_CUSTOMER_EMAIL_EXISTED);			            	 
			            	} else {
			            		processCommonExeption(result.data, ngDialog);
			            	}      	   		            	                 	  
			            }
		        })
		        .error(function (data, status) {
					processCommonExeption(SERVER_ERROR_MSG, ngDialog);
		        });		
		}			  
	};
		
    $(".nav li.tab_customers").addClass("active");       
}]);