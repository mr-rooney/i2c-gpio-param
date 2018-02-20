obj-m := i2c-gpio-param.o

PWD := $(shell pwd)
all:
	make -C $(KDIR) M=$(PWD) clean
	reset
	make -C $(KDIR) M=$(PWD) modules
clean:
	make -C $(KDIR) M=$(PWD) clean
