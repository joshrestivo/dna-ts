#**Domain objects**
#####**User**
```csharp
{
	"id": 1,
    "name": "Administrator",
    "username": "admin",
    "email": "admin@townsquare.com",
    "created_by": "admin",
    "updated_by": "admin",
    "created_at": "2016-10-13T16:39:19.961Z",
    "updated_at": "2016-10-13T16:39:19.961Z"
}
```
#####**ClientResource**
```csharp
{
    "id": 1,
    "name": "English Suite",
    "is_default": "true",
    "created_by": "admin",
    "updated_by": "admin",
    "created_at": "2016-10-13T16:39:19.961Z",
    "updated_at": "2016-10-13T16:39:19.961Z"
    "details":[{
    	"unique_name": "lblName",
    	"display_text": "Any text",
	    "created_by": "admin",
	    "updated_by": "admin",
	    "created_at": "2016-10-13T16:39:19.961Z",
	    "updated_at": "2016-10-13T16:39:19.961Z"
    }]
}
```
#####**Country**
```csharp
{
    "country_code": "US",
    "name": "United State"
}
```
#####**Location**
```csharp
{
	"id": 1,
    "longitude": 1,
    "latitude": 1,
    "name": "Saigon",
    "city": "Saigon",
    "state": "HCM",
    "country_code": "vn",
    "country": "Vietnam",
    "has_upcomming_events": true,
    "has_request_service": true,
    "has_location_info": true,
    "has_street_alerts": true,
    "created_by": "admin",
    "updated_by": null,
    "created_at": "2016-10-26T06:07:34.835Z",
    "updated_at": "2016-10-26T06:07:34.835Z",
    "client_resource": {
        "id": 2,
        "name": "Vietnamese",
        "is_default": false,
        "details": [......],
        "created_by": "admin",
        "updated_by": null,
        "created_at": "2016-10-26T04:25:46.512Z",
        "updated_at": "2016-10-26T04:25:46.512Z"
    }
}
```
#####**Bulletin**
```csharp
{
    "id": 1,
    "location_id": 1,
    "title": "Test",
    "description": "Test",
    "valid_from": "2001-01-01T12:12:00.000+00:00",
    "valid_to": "2001-01-01T12:12:01.000+00:00",
    "image_url": "https://s3.amazonaws.com/m-townsquare/uploads-staging/1477550844_29de7075-cfa7-4749-bba8-cfe6d40b0960.jpg",
    "image_width": 720,
    "image_height": 720,
    "thumbnail_url": "https://s3.amazonaws.com/m-townsquare/uploads-staging/150x150_1477550844_29de7075-cfa7-4749-bba8-cfe6d40b0960.jpg",
    "thumbnail_width": 150,
    "thumbnail_height": 150,
    "created_by": "admin",
    "updated_by": null,
    "created_at": "2016-10-27T06:47:33.911Z",
    "updated_at": "2016-10-27T06:47:33.911Z"
}
```
#####**Customer**
```csharp
{
    "id": 1,
    "name": "ABC",
    "phone": "756-347-4736",
    "address": "Address",
    "email": "ppthanhtn@gmail.com",
    "secret_key": "eb14201b-f0fb-430d-803f-bc5e00b506e4",
    "created_by": "admin",
    "updated_by": null,
    "created_at": "2016-10-27T06:47:33.911Z",
    "updated_at": "2016-10-27T06:47:33.911Z"
}
```
#####**Building**
```csharp
{
    "id": 1,
    "location_id": "1",
    "name": "name",
    "address": "Address",
    "zipcode": "zipcode",
    "image_url": "image_url",
    "image_width": "image_width",
    "image_height": "image_height",
    "thumbnail_url": "thumbnail_url",
    "thumbnail_width": "thumbnail_width",
    "thumbnail_height": "thumbnail_height",    
    "created_by": "admin",
    "updated_by": null,
    "created_at": "2016-10-27T06:47:33.911Z",
    "updated_at": "2016-10-27T06:47:33.911Z"
}
```
#####**StreetAlertFeed**
```csharp
{
    "date": "date",
    "link": "link"
}
```
#####**NewsFeed**
```csharp
{
    "date": "date",
    "link": "link",
    "title": "title",
    "description": "description",
    "thumbnail_url": "thumbnail_url",
    "thumbnail_width": xx,
    "thumbnail_height": xx
}
```
#**API Reference**
[1. Get all alert types](#1-get-all-alert-types)  
[2. Get all countries](#2-get-all-countries)  
[3. Ping](#3-ping)  
[4. Authentication](#4-authentication)  
[5. Get bulletins](#5-get-bulletins)  
[6. Get buildings](#6-get-buildings)  
[7. Get locations](#7-get-locations)  
[8. Get a location with its resources](#8-get-a-location-with-its-resources)  
[9. Get street alerts](#9-get-street-alerts)  
[10. Get upcoming events](#10-get-upcoming-events)  

###****Notes**
When partner use the API, remember to add a key 'Secret-Key' in the HTTP Header of all the HTTP requests. For internal usage, please use a hard-coded key 'ee9c6aaa512cd328c641d21f13bb2654353d36dc'

####**1. Get all alert types**
GET: <HOST>/api/1.0/alert_types  
######**Response:**
- {success=true, data=Alert types string collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."
- {success=false, data="INVALID_SESSION"}. On website, show message: "Your session is expired. Please login and try again.".

####**2. Get all countries**
GET: <HOST>/api/1.0/countries  
######**Response:**
- {success=true, data=[Country](#country) object collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."
- {success=false, data="INVALID_SESSION"}. On website, show message: "Your session is expired. Please login and try again.".

####**3. Ping**
GET: <HOST>/api/1.0/ping  
######**Response:**
- {success=true, data="pong"}
- {success=false, data="SYSTEM_ERROR"}

####**4. Authentication**
POST: <HOST>/api/1.0/auth  
######**Parameters:**
```csharp
{
  "longitude": 10.844365,
  "latitude": 106.640025,
  "client_os": "ios", // ios or android
  "device_token": "Test"
}
```
######**Response:**
- {success=true, data=[Location](#location) object}
- {success=false, data="SYSTEM_ERROR"}
- {success=false, data="INVALID_SESSION"}

####**5. Get bulletins**
GET: <HOST>/api/1.0/main/{location_id}/bulletins?page=1&limit=10 (default page = 1, limit=10 if missing)
######**Response:**
- {success=true, data=[Bulletin](#bulletin) objects}
- {success=false, data="SYSTEM_ERROR"}
- {success=false, data="INVALID_SESSION"}

####**6. Get buildings**
GET: <HOST>/api/1.0/main/{location_id}/buildings?page=1&limit=10 (default page = 1, limit=10 if missing)
######**Response:**
- {success=true, data=[Building](#building) objects}
- {success=false, data="SYSTEM_ERROR"}
- {success=false, data="INVALID_SESSION"}

####**7. Get locations**
GET: <HOST>/api/1.0/locations?page=1&limit=10 (default page = 1, limit=10 if missing)
######**Response:**
- {success=true, data=[Location](#location) objects}
- {success=false, data="SYSTEM_ERROR"}
- {success=false, data="INVALID_SESSION"}

####**8. Get a location with its resources**
GET: <HOST>/api/1.0/location/{id}
######**Response:**
- {success=true, data=[Location](#location) object}
- {success=false, data="SYSTEM_ERROR"}
- {success=false, data="INVALID_SESSION"}

####**9. Get street alerts**
GET: <HOST>/api/1.0/main/{id}/street-alerts
######**Response:**
- {success=true, data=[StreetAlertFeed](#streetalertfeed) objects}
- {success=false, data="SYSTEM_ERROR"}
- {success=false, data="INVALID_SESSION"}

####**10. Get upcoming events**
GET: <HOST>/api/1.0/main/{id}/news?page=1&limit=10 (default page = 1, limit=10 if missing)
######**Response:**
- {success=true, data=[NewsFeed](#newsfeed) objects}
- {success=false, data="SYSTEM_ERROR"}
- {success=false, data="INVALID_SESSION"}

#**For administration tool**
[1. Login](#1-login)  
[2. Logout](#2-logout)  
[3. Get all resources](#3-get-all-resources)  
[4. Create/update a resource](#4-createupdate-a-resource)  
[5. Update display text for a resource key](#5-update-display-text-for-a-resource-key)
[6. Add a resource key](#6-add-a-resource-key)
[7. Delete resource key](#7-delete-resource-key)
[8. Update alert types](#8-update-alert-types)  
[9. Get all locations](#9-get-all-locations)  
[10. Create/update a location](#10-createupdate-a-location)  
[11. Delete a location](#11-delete-a-location)  
[12. Get bulletins](#12-get-bulletins)  
[13. Create/update bulletin](#13-createupdate-bulletin)   
[14. Delete a bulletin](#14-delete-a-bulletin)  
[15. Get users](#15-get-users)  
[16. Create an user](#16-create-an-user)  
[17. Update an user](#17-update-an-user)  
[18. Delete an user](#18-delete-an-user)  
[19. Reset user password](#19-reset-user-password)  
[20. Get customers](#20-get-customers)  
[21. Create/update customer](#21-createupdate-customer)  
[22. Delete a customer](22-delete-a-customer#)  
[23. Get buildings](#23-get-buildings)  
[24. Create/update building](#24-createupdate-building)  
[25. Delete a building](#25-delete-a-building)  

####**1. Login**
POST: <HOST>/api/1.0/admin/login  
######**Parameters:**
```csharp
{  
    "username":"admin",  
    "password":"t0wnsq@re2016"  
}
```
######**Response:**
- {success=true, data=[User](#user) object}
- {success=false, data="INCORRECT"}. Show message: "Invalid login credential."
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."

####**2. Logout**
GET: <HOST>/api/1.0/admin/logout  
######**Response:**
- {success=true, data=null}

####**3. Get all resources**
GET: <HOST>/api/1.0/admin/resources  
######**Response:**
- {success=true, data=[ClientResource](#clientresource) collection}
- {success=false, data="INVALID_SESSION"}. On website, show message: "Your session is expired. Please login and try again.".
- {success=false, data="NOT_EXISTED"}. Show "The resource is not found.".
- {success=false, data="DUPLICATE"}. Show "This resource name is already in used.".
- {success=false, data="SYSTEM_ERROR"}.

####**4. Create/update a resource**
POST: <HOST>/api/1.0/admin/resource/save  
######**Parameters:**
```csharp
{  
  "id":"0", // 0 to create new, otherwise update
  "name":"English",
  "is_default":"true"
}
```
######**Response:**
- {success=true, data=[ClientResource](#clientresource) collection}
- {success=false, data="INVALID_SESSION"}
- {success=false, data="SYSTEM_ERROR"}

####**5. Update display text for a resource key**
POST: <HOST>/api/1.0/admin/resource/value/save  
######**Parameters:**
```csharp
{  
  "resource_id":1,
  "unique_name":"lblLogin",
  "display_text":"Login"
}
```
######**Response:**
- {success=true, data=null}
- {success=false, data="INVALID_SESSION"}
- {success=false, data="SYSTEM_ERROR"}

####**6. Add a resource key**
POST: <HOST>/api/1.0/admin/resource/key/add  
######**Parameters:**
```csharp
{  
  "unique_name": "lblLabel",
  "values": "[{\"resource_id\":1, \"display_text\": \"anytext\"},{\"resource_id\":2, \"display_text\": \"chu bat ky\"}]"
}
```
######**Response:**
- {success=true, data=null}
- {success=false, data="INVALID_SESSION"}
- {success=false, data="VALUE_MISSING"}. Show "Not enought display text for all resources."
- {success=false, data="SYSTEM_ERROR"}

####**7. Delete resource key**
POST: <HOST>/api/1.0/admin/resource/key/del  
######**Parameters:**
```csharp
{  
  "unique_name": "lblLabel"
}
```
######**Response:**
- {success=true, data=null}
- {success=false, data="INVALID_SESSION"}
- {success=false, data="SYSTEM_ERROR"}

####**8. Update alert types**
POST: <HOST>/api/1.0/admin/alert_types/save  
######**Parameters:**
```csharp
{
  "types":[
    "Crime & Safety",
    "Roads & Trails",
    "Social Events",
    "Govt. & Oversight Events",
    "Elections",
    "General Alerts",
    "Laws & Regulations"
  ]
}
```
######**Response:**
- {success=true, data=null}
- {success=false, data="SYSTEM_ERROR"}  
- {success=false, data="INVALID_SESSION"}

####**9. Get all locations**
GET: <HOST>/api/1.0/admin/locations  
######**Response:**
- {success=true, data=[Location](#location) collection}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**10. Create/update a location**
POST: <HOST>/api/1.0/admin/location/save  
######**Parameters:**
```csharp
{
  "id": 0,
  "name": "Saigon",
  "longitude": 1,
  "latitude": 1,
  "city": "Saigon",
  "state": "HCM",
  "country_code": "vn",
  "street_alerts_rss_feed_url": "street_alerts_rss_feed_url",
  "has_upcomming_events": true,
  "has_request_service": true,
  "has_location_info": true,
  "has_street_alerts": true,
  "client_resource_id": 2
}
```
######**Response:**
- {success=true, data=[Location](#location) object}
- {success=false, data="SYSTEM_ERROR"}  
- {success=false, data="INVALID_SESSION"}

####**11. Delete a location**
GET: <HOST>/api/1.0/admin/location/{id}/del  
######**Response:**
- {success=true, data=null}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**12. Get bulletins**
GET: <HOST>/api/1.0/admin/location/{location_id}/bulletins  
######**Response:**
- {success=true, data=[Bulletin](#bulletin) objects}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**13. Create/update bulletin**
POST: <HOST>/api/1.0/admin/location/{location_id}/bulletin/save  
######**Parameters:**
```csharp
Below json is used to decorate, but when implementing, please use multipart parameters of javascript's FormData object to make ajax request 
 
{
  "id": 0,
  "title": "title",
  "description": "description",
  "valid_from": "1/1/2001 12:12:00",
  "valid_to": "1/1/2001 12:12:01",
  "image": FILE // Optional
}
```
######**Response:**
- {success=true, data=[Bulletin](#bulletin) object}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="FROM_TO_INVALID"}. Show "Please select invalid date for from < to"
- {success=false, data="IMAGE_INVALID"}. Show "Please select image (png, bmp, jpg, jpeg)"
- {success=false, data="SYSTEM_ERROR"}.

####**14. Delete a bulletin**
GET: <HOST>/api/1.0/admin/location/{location_id}/bulletin/:id/del  
######**Response:**
- {success=true, data=null}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**15. Get users**
GET: <HOST>/api/1.0/admin/users  
######**Response:**
- {success=true, data=[User](#user) objects collection}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**16. Create an user**
POST: <HOST>/api/1.0/admin/user/create   
######**Parameters:**
```csharp
{
  "username": "ppthanhtn",
  "password": "thanh",
  "name": "Thanh Pham",
  "email": "ppthanhtn@gmail.com"
}
```
######**Response:**
- {success=true, data=[User](#user) object}
- {success=false, data="USERNAME_EXISTED"}. Show "Username is existed"
- {success=false, data="EMAIL_EXISTED"}. Show "Email is existed"
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**17. Update an user**
POST: <HOST>/api/1.0/admin/user/update   
######**Parameters:**
```csharp
{
  "id": 1,
  "name": "Thanh Pham",
  "email": "ppthanhtn@gmail.com"
}
```
######**Response:**
- {success=true, data=[User](#user) object}
- {success=false, data="EMAIL_EXISTED"}. Show "Email is existed"
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**18. Delete an user**
GET: <HOST>/api/1.0/admin/user/{user_id}/del   
######**Response:**
- {success=true, data=null}
- {success=false, data="NOT_EXISTED"}. Show "Deleted user is not existed"
- {success=false, data="DELETE_YOURSELF"}. Show "Your account is login"
- {success=false, data="DELETE_SUPER_ADMIN"}. Show "Super admin cannot be deleted"
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**19. Reset user password**
POST: <HOST>/api/1.0/admin/user/pwd/reset   
######**Parameters:**
```csharp
{
  "id": 1,
  "password": "thanh"
}
```
######**Response:**
- {success=true, data=[User](#user) object}
- {success=false, data="NOT_EXISTED"}. Show "User is not existed"
- {success=false, data="RESET_SUPER_ADMIN"}. Show "You cannot reset password for super admin"
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**20. Get customers**
GET: <HOST>/api/1.0/admin/customers  
######**Response:**
- {success=true, data=[Customer](#customer) objects collection}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**21. Create/update customer**
POST: <HOST>/api/1.0/admin/customer/save  
######**Parameters:**
```csharp
{
  "id": 0,
  "name": "name",
  "phone": "phone",
  "address": "description",
  "email": "ppthanhtn@gmail.com" //Unique
}
```
######**Response:**
- {success=true, data=[Customer](#customer) object}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="EMAIL_EXISTED"}. Show "Customer with the same email is already existed"
- {success=false, data="SYSTEM_ERROR"}.

####**22. Delete a customer**
GET: <HOST>/api/1.0/admin/customer/{id}/del  
######**Response:**
- {success=true, data=null}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**23. Get buildings**
GET: <HOST>/api/1.0/admin/location/{location_id}/buidings  
######**Response:**
- {success=true, data=[Building](#building) objects collection}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.

####**24. Create/update building**
POST: <HOST>/api/1.0/admin/location/{location_id}/building/save  
######**Parameters:**
```csharp
Below json is used to decorate, but when implementing, please use multipart parameters of javascript's FormData object to make ajax request 
 
{
  "id": 0,
  "name": "name",
  "address": "address",
  "zipcode": "zipcode",
  "image": FILE // Optional
}
```
######**Response:**
- {success=true, data=[Building](#building) object}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="IMAGE_INVALID"}. Show "Please select image (png, bmp, jpg, jpeg)"
- {success=false, data="SYSTEM_ERROR"}.

####**25. Delete a building**
GET: <HOST>/api/1.0/admin/location/{location_id}/building/:id/del  
######**Response:**
- {success=true, data=null}
- {success=false, data="INVALID_SESSION"}.
- {success=false, data="SYSTEM_ERROR"}.
