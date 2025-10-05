# DevContainer Resources

The `resources` folder contains tools and installers used by the dev container.  

## STM32CubeCLT Installation

**Why it’s handled manually in the container:**

- **License Agreement:** ST’s license must be accepted.  
- **Container Size:** The installer is large, so it’s not included directly in the image.  
- **User Control:** Allows you to choose the version and package format.  

**Automatic Setup:** During container creation, a script in this folder:  

- Unzips the installer if needed.  
- Makes the `.sh` executable.  
- Accepts the license automatically.  
- Sets up environment variables (`PATH` and `STM32CUBE_SVD_PATH`).  

**Recommended Version:** `1.19.0_25876_20250729_1159`  
**Package Format:** Linux generic `.sh` (or zipped `.sh`)  

> After the container is created, STM32CubeCLT is ready to use with all paths configured automatically.