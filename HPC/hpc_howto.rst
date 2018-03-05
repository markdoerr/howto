

High Performance Computing 
===========================


cmake
_____

listing symbols in object file:
nm -C object file



 qsub -l nodes=1:ppn=40,walltime=02:00:00 -I 
 qsub -l nodes=1:ppn=40:f2.2,walltime=02:00:00 -I  (2.2 GHz tact)
 
 -I : interactive shell
 
module load intel64

new intel compiler:
intel64/17.0up04


# likwid is a tool for pinning, set frequency, cores, ...

module load likwid
likwid
likwid-setFrequencies -f 2.2 # 2.2GHz

turbo-mode:
likwid-setFrequencies -f 2.201 # turbo mode

likwid-topology (-g)

change stack size in case default stack is too small:
ulimit -s unlimited

Nvidia CUDA nodes - k20m:
qsub -l nodes=1:ppn=40:k20m,walltime=01:00:00 -I


c++ compiler flags
___________________

c++ compiler options:
 -O3 -xHost -fno-alias
-no-vec : to swith off vector engine


OpenMP
------

Intel compiler directive
- qopenmp

shell var:
OMP_NUM_THREADS

# one core, filling closely one after the other
env  OMP_NUM_THREADS=1  OMP_PLACES=cores OMP_PROC_BIND=close ./a.out 
 
# streaming stores: direct save of data to memory without L2 cache
 
 #pragma vector temporal  //( swich streaming store off)
 #pragma vector nontemporal  //( swich streaming store on)
 
 debug pinning: KMP_AFFINITY=verbose
 env  KMP_AFFINITY=verbose OMP_NUM_THREADS=10  OMP_PLACES=cores OMP_PROC_BIND=close ./jacobi.exe < input


histogram example, add:

un int ssed = omp_get_thread_num()*6

#pragma omp for reduction(+:hist[0:16])
for

hist[rand_r(&seed)]
