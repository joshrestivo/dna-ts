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
    "country_code": "US",
    "unique_name": "lblLogin",
    "display_text": "Login"
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
[1. Get client UI resources](#1-get-client-ui-resources)  
[2. Get all alert types](#2-get-all-alert-types)
[3. Get all countries](#3-get-all-countries)

####**1. Get client UI resources**
GET: <HOST>/api/1.0/admin/resources/{countryCode}  
######**Response:**
- {success=true, data=[ClientResource](#clientresource) collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."

####**2. Get all alert types**
POST: <HOST>/api/1.0/admin/alert_types  
######**Response:**
- {success=true, data=Alert types string collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."

####**3. Get all countries**
POST: <HOST>/api/1.0/admin/countries  
######**Response:**
- {success=true, data=[Country](#country) object collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."

#**For administration tool**
[1. Login](#1-login)
[2. Logout](#2-logout)
[3. Create/update client UI resource](#3-createupdate-client-ui-resource)
[4. Delete client UI resource](#4-delete-client-ui-resource)
[5. Update alert types](#5-update-alert-types)

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

####**3. Create/update client UI resource**
POST: <HOST>/api/1.0/admin/resource/save  
######**Parameters:**
```csharp
{  
  "country_code":"us",
  "unique_name":"lblLogin",
  "display_text":"Login"
}
```
######**Response:**
- {success=true, data=[ClientResource](#clientresource) collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."

####**4. Delete client UI resource**
POST: <HOST>/api/1.0/admin/resource/del  
######**Parameters:**
```csharp
{  
  "country_code":"us",
  "unique_name":"lblLogin"
}
```
######**Response:**
- {success=true, data=null}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

####**5. Update alert types**
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
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

