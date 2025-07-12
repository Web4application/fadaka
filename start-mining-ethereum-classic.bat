
setx GPU_MAX_HEAP_SIZE 100	
setx GPU_MAX_USE_SYNC_OBJECTS 1	
setx GPU_SINGLE_ALLOC_PERCENT 100	
setx GPU_MAX_ALLOC_PERCENT 100	
setx GPU_MAX_SINGLE_ALLOC_PERCENT 100	
setx GPU_ENABLE_LARGE_ALLOCATION 100
setx GPU_MAX_WORKGROUP_SIZE 1024

@echo off
cd %~dp0
cls

SRBMiner-MULTI.exe --disable-cpu --algorithm etchash --pool de.etc.herominers.com:1150 --wallet 9ea4Jv2iHPSDv8xomrhByzgzscxE2oubyJkwJ9dyEGYxHjntNcd.331855
pause

