angular.module('app').controller('resetUserPasswordController',  ['$scope', '$http','ngDialog', function ($scope, $http, ngDialog) {
    $scope.adminUser = {
    	id:0
    };	
    var editAdminUser = sessionStorage.getItem("adminUserResetPassword");
	$scope.Init = function(){
    	//check add new or edit
	  	if (typeof editAdminUser !== 'undefined' && editAdminUser == null) {		
	  		showInfoDialog(ngDialog,"User not found!");
		} else {
			$scope.adminUser = JSON.parse(editAdminUser);
			$scope.IsUpdate = true;
		}
    };

   $scope.cancel=function(){
   		sessionStorage.removeItem("adminUserResetPassword");
		window.location.href='/main/admin-user/admin-user.html';
   };
   	
   
   $scope.reset = function(){
	   	if($scope.adminUserDetail.$valid)
	   	{
	   		if($scope.adminUser.password!== $scope.adminUser.confirm_Password){
	   			 showErrorDialog(ngDialog,"Confirm password not match!");
	   		}else{
	   			var data={
	   				id:$scope.adminUser.id,
	   				password:$scope.adminUser.password
	   			};
	   			
	   			$http.post(SERVICE_BASE_URL+'/admin/user/pwd/reset',data,{
   				withCredentials: true,
   				headers: {
		            		'Access-Token': $.cookie(AUTH_COOKIE_NAME)
		            		}
	            }).success(function (result) {
	            if (result.success) {
            		showInfoDialog(ngDialog,"Password updated");
            		sessionStorage.removeItem("adminUserResetPassword");
            		window.location.href='/main/admin-user/admin-user.html';
	        	}else {
	                		processCommonExeption(result.data, ngDialog);
	        	}
	         })
	         .error(function (error, status){
				       showErrorDialog(ngDialog,SERVER_ERROR_MSG);
  			}); 	
	   		}
   		}
   };
   
   	//active tab
   	$(".nav li.tab_admin_users").addClass("active"); 
}]);