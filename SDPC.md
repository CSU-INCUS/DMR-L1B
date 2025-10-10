# 1B-TB

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
<!-- docker run --rm -v <absolute-path-to>/static:/static <absolute-path-to>/L0:/L0 1b-tb -->
```
<!-- docker run --rm -v /home/amyburz/DMR-L1B/L1b/static:/static /home/amyburz/DMR-L1B/L0:/L0 1b-tb  -->

**Note:** You must use absolute paths for the volume mounts in the above command.

<!-- This will run the code using the inputs and the output filename specified and delete the container when
finished.
i
Typical results:
```
[D1/3] Processing scatteredInterpolant... 1 of 313 CT profiles  Elapsed time is 0.116893 seconds.
[D1/3] Querying scatteredInterpolant... 1 of 313 CT profiles    Elapsed time is 0.002108 seconds.
[D1/3] Processing scatteredInterpolant... 2 of 313 CT profiles  Elapsed time is 0.054131 seconds.
[D1/3] Querying scatteredInterpolant... 2 of 313 CT profiles    Elapsed time is 0.020186 seconds.
[D1/3] Processing scatteredInterpolant... 3 of 313 CT profiles  Elapsed time is 0.078130 seconds.
...
``` -->
