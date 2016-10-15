# Administration API Reference
### 1. Login
POST: <HOST>/api/1.0/admin/login  
**Parameters:**
```csharp
{  
    "username":"admin",  
    "password":"t0wnsq@re2016"  
}
```
**Response:**
- {success=true, data=User object}
- {success=false, data="INCORRECT"}. Show message: "Invalid login credential."
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

**User object:**
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

### 2. Logout
GET: <HOST>/api/1.0/admin/logout  
**Response:**
- {success=true, data=null}

### 3. Get client UI resources
GET: <HOST>/api/1.0/admin/resources/{countryCode}  
**Response:**
- {success=true, data=ClientResource collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

**ClientResource object:**
```csharp
{
    "country_code": "US",
    "unique_name": "lblLogin",
    "display_text": "Login"
}
```

### 4. Create/update client UI resource
POST: <HOST>/api/1.0/admin/resource/save  
**Parameters:**
```csharp
{  
  "country_code":"us",
  "unique_name":"lblLogin",
  "display_text":"Login"
}
```
**Response:**
- {success=true, data=ClientResource collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

### 5. Delete client UI resource
POST: <HOST>/api/1.0/admin/resource/del  
**Parameters:**
```csharp
{  
  "country_code":"us",
  "unique_name":"lblLogin"
}
```
**Response:**
- {success=true, data=null}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

### 6. Get all alert types
POST: <HOST>/api/1.0/admin/alert_types  
**Response:**
- {success=true, data=Alert types string collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

### 7. Update alert types
POST: <HOST>/api/1.0/admin/alert_types/save  
**Parameters:**
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
**Response:**
- {success=true, data=null}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

### 8. Get all countries
POST: <HOST>/api/1.0/admin/countries  
**Response:**
- {success=true, data=Country object collection}
- {success=false, data="SYSTEM_ERROR"}. Show a common message: "Server is error. Please contact site administrator for support."  

**Country object:**
```csharp
{
    "country_code": "US",
    "name": "United State"
}
```

