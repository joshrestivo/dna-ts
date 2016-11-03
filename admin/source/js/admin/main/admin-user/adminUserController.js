angular.module('app').controller('adminUserController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
	$scope.Init = function(){
		$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
	    getData();
	};
  		
    var getData = function(){
    	$http.get(SERVICE_BASE_URL+'/admin/users',{ withCredentials: true, headers: {'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')} }).success(function (result) {
            if (result.success) {
            	$scope.adminUsers = result.data;
            	$scope.TotalItems = $scope.adminUsers.length;
            }else {
	                	if(result.data == "INVALID_SESSION") {                	
	                		showErrorDialog(ngDialog,"Invalid login credantial");
	                	} else {                  	  	
	                		processCommonExeption(result.data, ngDialog);
	                	}
	                }
	            })
	            .error(function (error, status){
	            	showErrorDialog(ngDialog,SERVER_ERROR_MSG);
	  			}); 
    };
    
    $scope.addNewAdminUser = function(){
    		location.href="/main/admin-user/admin-user-detail.html";	
    };
    
    $scope.editAdminUser = function(adminUser){
    		sessionStorage.setItem("adminUser", JSON.stringify(adminUser));
			window.location.href=("/main/admin-user/admin-user-detail.html");
    };
    
    $scope.deleteAdminUser=function(adminUser){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete user: ' + adminUser.name + '?"}'
		})
		.then(function (value) {
           $http.get(SERVICE_BASE_URL+'/admin/user/'+adminUser.id+'/del  ',{ withCredentials: true ,headers: {'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')}}).success(function (result) {
			            if (result.success) {
			            getData();
			            }else {
				                	if(result.data == "INVALID_SESSION") {                	
				                		showErrorDialog(ngDialog,"Invalid login credantial");
				                	} else {                  	  	
				                		processCommonExeption(result.data, ngDialog);
				                	}
				                }
				            })
				            .error(function (error, status){
						       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
				  			}); 
	                    
        }, function (value) {});
	};
	
    //active tab
   	$(".nav li.tab_admin_users").addClass("active"); 
}]);