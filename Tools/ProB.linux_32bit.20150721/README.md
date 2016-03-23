This is a modified version of ProB and it is based on source code of ProB 1.5.0-beta2. 

# Purposes
This version aims for the experiment of model checking and refinement checking for linked CSP || B programs from Circus.

# Prerequisites
## Linux x86 or x86_64
I used Ubuntu 12.04 (32-bit) to build this version and demonstrated the cases. It can also run it on x86_64 but requires some 32-bit libraries under `libs` folder.

## tcl 8.5 (32-bit)
### Check current version
Use 

- `$echo 'puts $tcl_version; exit 0' | tclsh`
- or `$dpkg --get-selections | grep tcl8.5`

to check if we have tcl 8.5 installed. If not, install it.

### Installation 
- Install it by `$ sudo apt-get install tcl8.5` on Ubuntu
- Alternatively, you can install ActiveTcl 8.5 for Linux.
- Or just use the pre-installed ActiveTcl-8.5.tar.gz under `libs` folder

#### Ubuntu x86_64
If your system is x86_64, you need to install tcl 8.5 (32-bit). Better to use the pre-installed ActiveTcl-8.5.tar.gz

- Decompress *ActiveTcl-8.5.tar.gz* to `~/path/to/`
- Copy other libraries (libgmp.so.10, libXss.so, libXss.so.1, libXss.so.1.0.0) to `~/path/to/libs/` 
- Export the following environment variables in `StartProB.sh`
        
        export PATH=$PATH:~/path/to/ActiveTcl-8.5/bin
        export LD_LIBRARY_PATH=~/path/to/ActiveTcl-8.5/lib:~/path/to/libs
        export TCL_LIBRARY=~/path/to/ActiveTcl-8.5/lib/tcl8.5
 
# Run ProB 
- Decompress *ProB.linux_32.20150721-latest.tar.gz* by `$tar zxvf ProB.linux_32.20150721-latest.tar.gz`
- Invoke *StartProB.sh* to run ProB by `$./StartProB.sh` 
    + If there is an error about "Can not find libtk8.5.so library", please make sure this shared lib exists. In my case, only 'libtk8.5.so.0' file under `/usr/lib/`. So I just create a symbolic link file named 'libtk8.5.so' to 'libtk8.5.so.0'.
    + Alternatively, you can change the `LD_LIBRARY_PATH` in 'StartProB.sh' to point to the library path that contains 'libtk8.5.so'.

## Configuration 
- Change the 'User Mode' of ProB to *Normal* model. It is under 'Preferences/User Mode'. Then quit ProB and start it again.- This is only required for the first time run.

## Check Specification
- Open the Z program first. Let's say 'BufferSpec2-s3.tex'.
- Load its corresponding CSP file by 'File/Open Special/Use CSP File to Guide B...'. Let's say 'BufferSpec2-s3.csp'.

Now you can

- model check this CSP || Z program by 'Verify/Model Check',
- check CSP-M Assertions in the CSP program by 'Verify/Check CSP-M Assertions',
- animate it by clicking the events shown in 'Enabled operations' of the bottom middle window, checking the current state in the bottom left window and tracking the trace in the bottom right window,
- or save its state space for later refinement checking by 'Verify/Save State for Later Refinement Check' (a file named 'BufferSpec2-s3.P' will be generated in the same directory of the CSP || Z program).

Particularly, you can use the temporal logic to check this program as well by 'Verify/Check LTL/CTL Assertions'.

## Check Implementation 
- Open the Z program first. Let's say 'ReactiveBuffer-s3.tex'.
- Load its corresponding CSP file by 'File/Open Special/Use CSP File to Guide B...'. Let's say 'ReactiveBuffer-s3.csp'.

Now you can do same things as for the specification plus the refinement checking by clicking 'Verify/Trace Refinement Check...', selecting the saved state file 'BufferSpec2-s3.P' and then pressing 'Refinement Check' button. You can check failures as well by enabling 'Check Failures' option.

# What happens if we load paired CSP and Z programs wrong? 
Imagine you load a Z file but load another CSP program instead of its paired one. For example, you load 'BufferSpec2-s2.tex' for Z but use 'BufferSpec2-s3.csp' to guide, what will happen?

## Configurations in CSP is strictly than that in Z
For example, we load 'BufferSpec2-s3.tex' and 'BufferSpec2-s2.csp' that means *maxbuff* equal to 3 in Z and 2 in CSP. The model checking won't find a deadlock.  

## Configurations in Z is stricter than that in CSP 
For example, we load 'BufferSpec2-s2.tex' and 'BufferSpec2-s3.csp' that means *maxbuff* equal to 2 in Z and 3 in CSP. The model checking will find a deadlock and a counterexample is shown in the 'History' trace window. This trace can be very helpful to analyse and correct the programs.

# What happens if we check refinement for different configurations between the specification and the implementation? 
When checking the refinement between 'BufferSpec2-s3' and 'ReactiveBuffer-s3', after loading 'ReactiveBuffer-s3.tex' and 'ReactiveBuffer-s3.csp', we need to choose the saved state of the specification. If 'BufferSpec2-s3.P' is chosen, refinement checking won't find any problems. But what happens if we choose 'BufferSpec2-s2.P'?

- An error occurs and a counterexample is provided.

