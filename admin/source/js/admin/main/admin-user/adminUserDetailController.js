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
   		window.location.href = "/main/building/building.html";
   };
   	
   $scope.save = function(){
	   	if($scope.adminUserDetail.$valid)
	   	{
	   		if($scope.adminUser.password!== $scope.adminUser.confirm_Password){
	   			 showErrorDialog(ngDialog,"Confirm password not match!");
	   		}else{
	   			$http.post(SERVICE_BASE_URL+'/admin/user/create',$scope.adminUser,{
   				withCredentials: true,
   				headers: {
		            		'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')
		            		}
	            }).success(function (result) {
	            if (result.success) {
            		showInfoDialog(ngDialog,"User admin added.");
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
   
   $scope.update = function(){
	   	if($scope.adminUserDetail.$valid)
	   	{
	   		var data={
	   			id:$scope.adminUser.id,
	   			name:$scope.adminUser.name,
	   			email:$scope.adminUser.email
	   		};
	   		alert(JSON.stringify(data));
	   			$http.post(SERVICE_BASE_URL+'/admin/user/update',data,{
   				withCredentials: true,
   				headers: {
		            		'Access-Token': readCookie('TOWNSQUARE_ACCESS_TOKEN')
		            		}
	            }).success(function (result) {
	            if (result.success) {
	            	showInfoDialog(ngDialog,"User admin updated.");
	        	}else {
	                		processCommonExeption(result.data, ngDialog);
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