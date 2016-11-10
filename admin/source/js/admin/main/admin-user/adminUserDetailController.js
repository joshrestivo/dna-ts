angular.module('app').controller('adminUserDetailController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.adminUser = {
    	id:0
    };	
    var editAdminUser = sessionStorage.getItem("adminUser");
	sessionStorage.removeItem("adminUser");
	
    $scope.Init = function(){
    	//check add new or edit
	  	if (typeof editAdminUser !== 'undefined' && editAdminUser == null) {		
	  		$scope.IsUpdate = false;
		} else {
			$scope.adminUser = JSON.parse(editAdminUser);
			$scope.IsUpdate = true;
		}
    };

   $scope.cancel=function(){
   		gotoAdminUserPage();
   };
   	
   $scope.save = function(){
	   	if($scope.adminUserDetail.$valid) {
	   		if($scope.adminUser.password!== $scope.adminUser.confirm_Password){
	   			 showErrorDialog(ngDialog,"Confirm password not match!");
	   		} else {
	   			$http.post(SERVICE_BASE_URL+'/admin/user/create',$scope.adminUser,{withCredentials: true,headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)}})
            		.success(function (result) {
			            if (result.success) {
		            		gotoAdminUserPage();
			        	}else {
                			if(result.data == ErrorCode.USERNAME_EXISTED){
			            		showErrorDialog(ngDialog, ErrorMessage.CREATE_USER_USERNAME_EXISTED);
			            	} else if(result.data == ErrorCode.EMAIL_EXISTED) {
			            		showErrorDialog(ngDialog, ErrorMessage.CREATE_USER_EMAIL_EXISTED);
			            	} else {
			            		processCommonExeption(result.data, ngDialog);
			            	}    
			        	}
	        		 })
	         		.error(function (error, status){
				       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
  					}); 	
	   		}
   		}
   };
   
   $scope.update = function(){
	   	if($scope.adminUserDetail.$valid)
	   	{
	   		var data={
	   			id:$scope.adminUser.id,
	   			name:$scope.adminUser.name,
	   			email:$scope.adminUser.email
	   		};
	   		
   			$http.post(SERVICE_BASE_URL+'/admin/user/update',data,{withCredentials: true,headers: {'Access-Token': $.cookie(AUTH_COOKIE_NAME)}})
				.success(function (result) {
				    if (result.success) {
				    	gotoAdminUserPage();
					}else {
						if(result.data == ErrorCode.EMAIL_EXISTED) {
		            		showErrorDialog(ngDialog, ErrorMessage.UPDATE_USER_EMAIL_EXISTED);
		            	} else {
		            		processCommonExeption(result.data, ngDialog);
		            	}    
					}
				 })
				 .error(function (error, status){
				       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
				});
   		}
   };
   
   	//active tab
   	$(".nav li.tab_admin_users").addClass("active"); 
}]);