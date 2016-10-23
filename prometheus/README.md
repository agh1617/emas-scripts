# Prometheus

## Setup

### Erlang/OTP 17.5 module

Start by downloading and unpacking the Erlang/OTP distribution file:

```bash
wget http://erlang.org/download/otp_src_17.5.tar.gz
tar xf otp_src_17.5.tar.gz
```

Change directory into base and set $ERL_TOP variable:

```bash
cd otp_src_17.5
export ERL_TOP=`pwd`
```

Load build dependent modules (optional):

```bash
module load plgrid/tools/java7/1.7.0_80
module load plgrid/tools/unixodbc/2.3.2
```

Configure build:

```bash
./configure --prefix=$HOME/.pkg/erlang/17.5
```

If you get errors when building, try setting the LANG variable:

```bash
export LANG=C
```

Build release:

```bash
make
```

Build and perform "smoke" test:

```bash
make release_tests
cd release/tests/test_server
$ERL_TOP/bin/erl -s ts install -s ts smoke_test batch -s init stop
```

(Open `$ERL_TOP/release/tests/test_server/index.html` in your web browser and make sure that there are zero failed test cases.)

Install release:

```bash
make install
```

Add module path:

```bash
cd $HOME
mkdir .modulefiles

module use .modulefiles
echo $MODULEPATH
```

Create module file for installed Erlang release:

```bash
mkdir .modulefiles/erlang
vim .modulefiles/erlang/17.5.lua
```

```lua
local home    = os.getenv("HOME")
local version = myModuleVersion()
local pkgName = myModuleName()
local pkg     = pathJoin(home,".pkg",pkgName,version,"bin")
prepend_path("PATH", pkg)
```

## Usage

## Useful links

* [Transitioning from PBS to Slurm (Cheetsheet)](https://slurm.schedmd.com/rosetta.pdf)
* [Slurm documentation](http://slurm.schedmd.com/documentation.html)
* [Prometheus - podstawy](https://kdm.cyfronet.pl/portal/Prometheus:Podstawy)
