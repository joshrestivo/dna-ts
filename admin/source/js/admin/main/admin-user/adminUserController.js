angular.module('app').controller('adminUserController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
	$scope.Init = function(){
		$scope.currentPage = 1;
	    $scope.itemPerPage = ITEM_PER_PAGE;
	    $scope.maxSize = PAGE_MAX_SIZE;
	    getData();
	};
  		
    var getData = function(){
    	$http.get(SERVICE_BASE_URL+'/admin/users',{ withCredentials: true, headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)} })
			.success(function (result) {
	            if (result.success) {
	            	$scope.adminUsers = result.data;
	            	$scope.TotalItems = $scope.adminUsers.length;
	            } else {        	  	
        			processCommonExeption(result.data, ngDialog);
                }
            })
            .error(function (error, status){
            	showErrorDialog(ngDialog,SERVER_ERROR_MSG);
  			}); 
    };
    
    $scope.addNewAdminUser = function(){
		gotoAdminUserDetailPage();	
    };
    
    $scope.editAdminUser = function(adminUser){
		sessionStorage.setItem("adminUser", JSON.stringify(adminUser));
		gotoAdminUserDetailPage();
    };
    
    $scope.resetPasswordAdminUser = function(adminUser){
		sessionStorage.setItem("adminUserResetPassword", JSON.stringify(adminUser));
		gotoAdminUserResetPasswordPage();
    };
    
    $scope.deleteAdminUser=function(adminUser){
    	ngDialog.openConfirm({
		    template: 'confirm-message',
	        data: '{"message":"Are you want to delete user: ' + adminUser.name + '?"}'
		})
		.then(function (value) {
           $http.get(SERVICE_BASE_URL+'/admin/user/'+adminUser.id+'/del  ',{ withCredentials: true ,headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)}})
       			.success(function (result) {
		            if (result.success) {
		            	getData();
		            } else {	                	                	  	
                		if(result.data == ErrorCode.NOT_EXISTED){
		            		showErrorDialog(ngDialog, ErrorMessage.DELETE_USER_NOT_EXISTED);
		            	} else if(result.data == ErrorCode.DELETE_YOURSELF) {
		            		showErrorDialog(ngDialog, ErrorMessage.DELETE_USER_DELETE_YOURSELF);
		            	}else if(result.data == ErrorCode.DELETE_SUPER_ADMIN) {
		            		showErrorDialog(ngDialog, ErrorMessage.DELETE_USER_DELETE_SUPER_ADMIN);
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