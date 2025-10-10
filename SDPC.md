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
[D3/3] Processing scatteredInterpolant... 310 of 313 CT profiles        Elapsed time is 0.032302 seconds.
[D3/3] Querying scatteredInterpolant... 310 of 313 CT profiles  Elapsed time is 7.630959 seconds.
---> W2T_cpute_dt_corr: 273 s: el 367
---> W2T_cpute_dt_corr: 271 s: el 367
---> W2T_cpute_dt_corr: 67 s: el 367
---> W2T_cpute_dt_corr: 66 s: el 367
Creating L1C NETCDF: ../data/dar_l1c_test_output.nc
Elapsed time is 804.529243 seconds.
```

## Build into to a Docker image
Mathworks instructions: https://www.mathworks.com/help/compiler/package-matlab-standalone-applications-into-docker-images.html

Download the Matlab compiler if it doesn't already exist on the server:
```
compiler.runtime.download
```

Compile the code:
```
parallelProfileFile = fullfile(prefdir,'parallel.mlsettings');
dar1capp = compiler.build.standaloneApplication('dar_data_l1b_to_l1c.m', "AdditionalFiles",{'<absolute-path-to>/functions', parallelProfileFile}) 

<!-- dar1capp = compiler.build.standaloneApplication('dar_data_l1b_to_l1c.m', 'AdditionalFiles','<absolute-path-to>/functions')  -->

<!-- dar1capp = compiler.build.standaloneApplication('dar_data_l1b_to_l1c.m') -->

<!-- parallelProfileFile = fullfile(prefdir,'parallel.mlsettings');
dar1capp = compiler.build.standaloneApplication('dar_data_l1b_to_l1c.m', "AdditionalFiles", parallelProfileFile) -->


```

Create Docker Image
```
compiler.package.docker(dar1capp, 'ImageName', '1c-zrg-zac')
```

## Run the code in Docker
From any directory on the server, assuming the 1C-ZRG-ZAC image was successfully created above:
```
docker run --rm -v <absolute-path-to>/data:/data 1c-zrg-zac

```

**Note:** You must use absolute paths for the volume mounts in the above command.

This will run the code using the inputs and the output filename specified and delete the container when
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
```
