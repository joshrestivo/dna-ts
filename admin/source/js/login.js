var app = angular.module("login", ['ui.bootstrap']);
app.controller('loginController', function ($scope, $http) {
    $scope.user_name = "";
    $scope.password = "";
    $("#user_name").focus();
   	$scope.authenticate = function () {
        $scope.errorMessage = "";
        if ($scope.user_name == "" || $scope.password == "") {
            $scope.errorMessage = "Please input the user name or password.";
            return;
        }

        showLoadingImage("div.login-container");
        $http.get(SERVICE_URL + '/api/admin/login')
            .success(function (result) {
                hideLoading("div.login-container");
                if (result.Success) {
                    
                } else {
                    if (result.Data.indexOf("SYSTEM_ERROR=>") === 0) {
                        $scope.errorMessage = SERVER_ERROR_MSG;
                    } else {
                        
                    }

                    $("#user_name").focus();
                }
            });
    }
});