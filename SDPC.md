# 1B-TB

## SDPC Data Access Notes
Input test data and reference files are available on kilo-ceph in the INCUS data directory under:

Input Data: `1B-TB-input`
Reference Files: `1B-TB-reference`

## Running in Matlab
The DMR L0->L1B code is written in Matlab.

<!-- ### Assumptions for this example:
* The working directory contains the DMR-L1B repository directory (`DMR-L1B`) and the 
data directory (`data`) at the same level.
* The `data` directory:
  * contains the input 1B-ZM files (`l1b_test_data_D1.nc`, `l1b_test_data_D2.nc`, `l1b_test_data_D3.nc`)
  * is where the output L1C file (`dar_l1c_test_output.nc `) will be written. -->

In Matlab's command prompt, from the `DMR-L1B/L1b/src` repository directory run the command below (which also prints the
execution time):
```
tic; main_M1; toc
```

Typical results:
```
...
...
Successfully loaded all variables from ../static/static_parameters.nc
Successfully loaded all variables from ../../L0/outputs/DMR_L0_20241021T224728_20241021T230256_V1.2.0_20250912T195641.nc
```

## Build into to a Docker image
Mathworks instructions: https://www.mathworks.com/help/compiler/package-matlab-standalone-applications-into-docker-images.html

Download the Matlab compiler if it doesn't already exist on the server:
```
compiler.runtime.download
```

Compile the code:
```
<!-- dmr1bapp = compiler.build.standaloneApplication('L1b/src/main_L1.m') -->
```

Create Docker Image
```
compiler.package.docker(dmr1bapp, 'ImageName', '1b-tb')
```

## Run the code in Docker
From any directory on the server, assuming the 1B-TB image was successfully created above:
```
<!-- docker run --rm -v <absolute-path-to>/data:/data -v <absolute-path-to>/reference:/reference -v <absolute-path-to>/output:/output 1b-tb -->
```

<!-- docker run --rm -v /mnt/kilo-ceph/INCUS_data/1B-TB-input:/data -v /mnt/kilo-ceph/INCUS_data/1B-TB-reference:/reference -v /home/amyburz/dev-output/1b-tb/0.1.0-test:/output 1b-tb -->

**Note:** You must use absolute paths for the volume mounts in the above command.

This will run the code using the inputs and the output filename specified and delete the container when
finished.

Typical results:
```
Successfully loaded all variables from /reference/static_parameters.nc
Successfully loaded all variables from /data/DMR-L0/DMR_L0_20241021T224728_20241021T230256_V1.2.0_20250912T195641.nc
Elapsed time is 19.604919 seconds.
...
```
