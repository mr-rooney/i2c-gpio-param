credits
=======
Thanks to Krzysztof A. Adamski for providing this source code. The original code can be found 
at https://github.com/kadamski/i2c-gpio-param.

i2c-gpio-param
==============
Linux kernel module for adding GPIO bitbanged I²C host device. It uses i2c-gpio module
but adds a way to dynamicaly add and remove busses when kernel is load and using sysfs
interface.
It is designed for and tested on Raspberry Pi but it should work (with possible minor changes like
pin_blacklist) on any other devices.

Installation
------------

1.  Ensure that you have CONFIG_I2C_GPIO enabled in your kernel.
2.  In case of a cross-compilation, pass ARCH and CROSS_COMPILE options to make command. For example:
        host> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- all KDIR=<PATH_TO_KERNEL_SRC>

3.  Load resulting i2c-gpio-param.ko module:
        raspi> sudo insmod i2c-gpio-param.ko

Usage
-----

Linux kernel module for adding GPIO bitbanged I²C host device. 

It accepts following parameters:
  - `busid` (default 7) - I²C bus id (will create i2c-`busid` device)
  - `sda` (default 0) - GPIO pin number to be used as `SDA`
  - `scl` (default 1) - GPIO pin number to be used as `SCL`
  - `udelay` - SCL frequency is (500 / `udelay`)
  - `timeout` - clock streaching timeout
  - `sda_od` (bool) - SDA is configured as open drain
  - `scl_od` (bool) - SCL is configured as open drain
  - `scl_oo` (bool) - SCL output drivers cannot be turned of (no clock stretching)

You can add additional i2c-gpio busses or remove existing ones with sysfs interface:

  - `/sys/class/i2c-gpio/add_bus` accepts following space delimited integer arguments:

      busid ada scl [udelay] [timeout] [sda_od] [scl_od] [scl_oo]

  - `/sys/class/i2c-gpio/remove_bus` accepts one integer argument - busid

Example:

   # echo 5 2 3 > /sys/class/i2c-gpio/add_bus

   # echo 5 > /sys/class/i2c-gpio/remove_bus
