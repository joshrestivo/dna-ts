#**Domain objects**
#####**User**
```csharp
{
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
#**API Reference**
[1. Get all alert types](#1-get-all-alert-types)  
[2. Get all countries](#2-get-all-countries)  

###****Notes**
When using the API from mobile client (or partners), remember to add a key 'Secret-Key' in the HTTP Header of the HTTP request. For internal usage, please use a hard-coded key 'ee9c6aaa512cd328c641d21f13bb2654353d36dc'

####**1. Get all alert types**
POST: <HOST>/api/1.0/admin/alert_types  
######**Response:**
- {success=true, data=Alert types string collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."
- {success=false, data="INVALID_SESSION"}. On website, show message: "Your session is expired. Please login and try again.".

####**2. Get all countries**
POST: <HOST>/api/1.0/admin/countries  
######**Response:**
- {success=true, data=[Country](#country) object collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."
- {success=false, data="INVALID_SESSION"}. On website, show message: "Your session is expired. Please login and try again.".

#**For administration tool**
[1. Login](#1-login)  
[2. Logout](#2-logout)  
[3. Get all resources](#3-get-all-resources)  
[4. Create/update a resource](#4-createupdate-a-resource)  
[5. Update display text for a resource key](#5-update-display-text-for-a-resource-key)
[6. Add a resource key](#6-add-a-resource-key)
[7. Delete resource key](#7-delete-resource-key)
[8. Update alert types](#8-update-alert-types)  

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

