
setx GPU_MAX_HEAP_SIZE 100	
setx GPU_MAX_USE_SYNC_OBJECTS 1	
setx GPU_SINGLE_ALLOC_PERCENT 100	
setx GPU_MAX_ALLOC_PERCENT 100	
setx GPU_MAX_SINGLE_ALLOC_PERCENT 100	
setx GPU_ENABLE_LARGE_ALLOCATION 100
setx GPU_MAX_WORKGROUP_SIZE 1024

@echo off
@cd /d "%~dp0"

:: mine to herominers
rigel.exe -a autolykos2 -o stratum+tcp://de.ergo.herominers.com:1180 -u 9ea4Jv2iHPSDv8xomrhByzgzscxE2oubyJkwJ9dyEGYxHjntNcd.331855 --log-file logs/miner.log
pause
