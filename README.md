# scripts
Includes some scripts for Android testing

[1]: Script build_Khronos_CTS.sh is used for https://github.com/KhronosGroup/VK-GL-CTS. Branch: **vulkan-cts-1.2.5**

1. Change default tmp path (note for [1])

* If your root disk is full, please manually your tmp path as below:
<pre>
kyndytran@kyndytran:/data/04_VK_CTS/VK-GL-CTS$ git diff
diff --git a/scripts/android/build_apk.py b/scripts/android/build_apk.py
index a5fce35bd..808bc8f54 100644
--- a/scripts/android/build_apk.py
+++ b/scripts/android/build_apk.py
@@ -893,7 +893,8 @@ def findSDK ():
                return None
 
 def getDefaultBuildRoot ():
-       return os.path.join(tempfile.gettempdir(), "deqp-android-build")
+       return os.path.join("/data/04_VK_CTS/tmpdir_path/", "deqp-android-build")
</pre>
* By default, function **getDefaultBuildRoot** will get default tmp path of your PC. To custom tmp directory, please change /data/04_VK_CTS/tmpdir_path/ with your expected directory.
