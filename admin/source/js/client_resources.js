var app = angular.module("client_resource", ['ui.bootstrap']);
app.controller('clientResourceController', function ($scope, $http) {
    $scope.maxSize = 5; 
    $scope.itemPerPage = 20;
    $scope.reverse = false;    
   	$scope.TotalItems = 1;
   	$scope.currentPage = 1;
   	$scope.clientResources = [
   		{ Name:"Resource1", DisplayText:"New York"},
   		{ Name:"Resource2", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"},
   		{ Name:"Resource3", DisplayText:"New York"}
   	];
   	
    $(".nav li.tab_client_resources").addClass("active");       
});
angular.bootstrap(document.getElementById("client_resource"), ['client_resource']);