angular.module('app').controller('bulletinDetailController',  ['$scope', '$http', 'ngDialog', function ($scope, $http, ngDialog) {	
	
	var bulletin = sessionStorage.getItem("bulletin");
	sessionStorage.removeItem("bulletin");
	var locationId = sessionStorage.getItem("locationId");
	sessionStorage.removeItem("locationId");
	
	$scope.Init = function () {
		$scope.Model = { id: 0 };
		$scope.IsUpdate = false;
		if (typeof bulletin !== 'undefined' && bulletin == null) {		
			$scope.IsUpdate = false;
		} else {
			$scope.IsUpdate = true;
			bulletin = JSON.parse(bulletin);						
			$scope.Model = bulletin;
			$scope.Model.id = bulletin.id;
			$scope.Model.valid_from = new Date(bulletin.valid_from);
			$scope.Model.valid_to = new Date(bulletin.valid_to);
		}
	};
		
	$scope.createUpdateBulletin = function () {
		if($scope.updateBulletin.$valid) {			
			var formData = new FormData();
			formData.append('id', $scope.Model.id);
			formData.append('title',$scope.Model.title);
			formData.append('description',$scope.Model.description);
			formData.append('valid_from', $scope.Model.valid_from);
			formData.append('valid_to', $scope.Model.valid_to);
			if ($scope.file) {
				formData.append('image',$scope.file);
			}
		
			$http.post(SERVICE_BASE_URL + '/admin/location/' + locationId + '/bulletin/save',formData, 
				{
					withCredentials: true,
					transformRequest: angular.identity,
					headers: {
						'Access-Token': $.cookie(AUTH_COOKIE_NAME),
	        			'Content-Type': undefined
	    				}
				})
		        .success(function (result) {
					 if (result.success) {	      
				          	location.href="/main/bulletins/bulletins.html";
			            } else {    
			            	if(result.data == ErrorCode.FROM_TO_INVALID){
			            		showErrorDialog(ngDialog, ErrorMessage.CREATE_BULLETIN_FROM_TO_INVALID);
			            	} else if(result.data == ErrorCode.IMAGE_INVALID) {
			            		showErrorDialog(ngDialog, ErrorMessage.CREATE_BULLETIN_IMAGE_INVALID);
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
	
	$scope.format = 'yyyy/MM/dd';
    $scope.openValidFrom = function () {
        $scope.isOpenValidFrom = true;
    };

    $scope.openValidTo = function () {
        $scope.isOpenValidTo = true;
    };
		
    $(".nav li.tab_bulletins").addClass("active");       
}]);