#  Safe Device Check App

A simple **Flutter app** that demonstrates the concept of **Device Security Validation** using the [`safe_device`](https://pub.dev/packages/safe_device) package.  
The app checks the user’s device against multiple security rules before allowing access.  
If the device fails any check (e.g., running on an emulator, rooted/jailbroken, developer mode enabled), the user is redirected to a **Blocked Page** instead of the home screen.

---

##  Features
- ✅ Detect if the device is **Rooted / Jailbroken**  
- ✅ Detect if running on an **Emulator**  
- ✅ Detect **Mock Location** usage  
- ✅ Detect if **Developer Mode** is enabled  
- ✅ Ensure the device passes the **Safety Check**  
- ✅ Redirect blocked devices to an **Access Restricted screen**  
