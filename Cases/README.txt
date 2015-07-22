This directory contains several case studies, and for each subdirectory it is a case study.

Each case has the similar directory/file tree shown below. 

|-- ReactiveBuffer
| |--Implementation                     [the implementation or refinement of the specification]
| | |--Circus                           [the Circus program of the implementation]
| | | |--DisBuffer.tex
| | |--CSP_Z                            [the linked CSP || Z program corresponding to the Circus program above]
| | | |--ReactiveBuffer-s1.csp
| | | |--ReactiveBuffer-s1.tex
| |--Specification                      [the specification]
| | |--Circus                           [the Circus program of the specification]
| | | |--buffer_spec.tex
| | |--CSP_Z                            [the linked CSP || Z program corresponding to the Circus specification]
| | | |--BufferSpec2-s1.csp
| | | |--BufferSpec2-s1.tex

The Circus program can be parsed and typechecked by CZT (http://sourceforge.net/projects/czt/files/czt-ide/). The latest stable release is czt_1_5_0_bin.jar.

The CSP || Z program is model-checked by the modified ProB version under "Tools/ProB" of this repository.
