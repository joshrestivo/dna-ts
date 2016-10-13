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

