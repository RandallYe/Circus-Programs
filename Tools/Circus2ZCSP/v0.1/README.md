This is the first version (v0.1) of Circus2ZCSP, a translator to transform a Circus specification to CSP || Z.

# Usage

`$java -jar circus2zcsp-0.1-20160315.jar spec.tex [spec1.tex [...]] [-d] [-v] [-V]`

## help
Invoke without arguments will print help information
- `$java -jar circus2zcsp-0.1-20160315.jar`

        usage: java -jar circus2zcsp.jar spec.tex [spec1.tex [...]] [-d] [-v] [-V]
        
        Circus2ZCSP is a translator to link one (or more) Circus specification to its
        corresponding model in Z || CSP, which is sequentially model-checked by ProB.
        Options:
            -d,--verbose      run in debug mode
            -v,--version      show version
            -V,--Versions     show detailed versions information
        For any problems, please contac <ky582@york.ac.uk> or <ye.randall@gmail.com>

## debug mode
Invoke with -d option will make the tool run in the debug mode and more information provided
- `$java -jar circus2zcsp-0.1-20160315.jar -d circus_spec.tex`

## show current version
- `$java -jar circus2zcsp-0.1-20160315.jar -v`

        Current Circus2ZCSP version: 0.1

## show version history
- `$java -jar circus2zcsp-0.1-20160315.jar -V`

        Current Circus2ZCSP version: 0.1
        
        ==> 0.1
        This is the first release.
        It is capable of translating all constructs in the reactive buffer and the steam
         boiler cases.
        Limitations:
            1. External choice of actions are only available to "prefixed" actions (such
         as basic actions, prefixing, guarded commands), and compound CSP actions of the
        se "prefixed" actions.
            2. Parallel composition and interleaving for actions are not supported if bo
        th actions share variables in scope.
            3. Operator template is not supported.
            4. Reflexive-transitive closure (*) is not supported.
