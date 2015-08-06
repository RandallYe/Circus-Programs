This is a perl script to compute fseq(s,n), a finite set of finite sequence (instead of infinite set of finite sequence by \seq of Z notation), where s is a set of elements and n is the maximum length of finite sequence. The cardinality of the final set is equal to (cs^0+cs^1+...+cs^n where cs=card(s)).

#### Usage:

        ./fseq.pl 1 null

This will generate `{<>}`

        ./fseq.pl n e1 [e2 ...]

Where e1, e2, ... are a list of elements in s 

#### Examples

        ./fseq.pl 1 0

will generate `{<>, <0>}`

        ./fseq.pl 2 0

will generate `{<>, <0>, <0,0>}`

        ./fseq.pl 2 0 1

will generate `{<>, <0>, <1>, <0,0>, <0,1>, <1,0>, <1,1>}`
