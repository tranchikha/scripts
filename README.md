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

[2]: Build options

There are 2 build options which are supported now.

* 1: VULKAN
* 2: OPENGLES

User could only choose one of them and run below command to build:
* For 1: ./build_Khronos_CTS.sh VULKAN
* For 2: ./build_Khronos_CTS.sh OPENGLES
* If nothing is input or input wrong target, print warning and choose OPENGLES as default build target

[3] Troubleshooting

1. Can't run OPENGLES test
* Test command: am start -n org.khronos.gl_cts/org.khronos.cts.ES32Activity -e logdir "/sdcard/logs" -e verbose "true"
* Log:
<pre>
05-21 00:12:36.208 26943 26959 I dEQP    : Writing test log into /sdcard/logs/configs.qpa
05-21 00:12:36.208 26943 26959 I dEQP    : ERROR: Unable to open test log output file '/sdcard/logs/configs.qpa'.
05-21 00:12:36.209 26943 26959 I dEQP    : RenderThread: Failed to open test log file '/sdcard/logs/configs.qpa'
</pre>
* Root cause: Folder /sdcard/logs/ is not existed on device yet.
* Solution: Create folder /sdcard/logs/ (mkdir -pv /sdcard/logs/)

[4] Android Khronos test command:
* https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/openglcts/README.md#android-1

