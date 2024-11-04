# -*- coding:utf-8 -*-
from __future__ import division

import udm
from udm import *
import time

data = [1, 2, 3, 4, 8, 7, 6, 5, 7, 5, 3, 1, 4, 6, 8, 10]

udm = udm('COM8', 921600)
print("")

CSR_LED_ADDR    = 0x00000000
CSR_SW_ADDR     = 0x00000004
TESTMEM_ADDR    = 0x80000000
CSR_MATH_ADDR   = 0x20000000
CSR_MATH_RES_ADDR   = 0x20000040
CSR_MATH_START   = 0x20000050
CSR_MATH_BUSY   = 0x20000054


udm.wr32(CSR_LED_ADDR, 0xFF00)
print("SW read: ", hex(udm.rd32(CSR_SW_ADDR)))

udm.wrarr32(CSR_MATH_ADDR, data)
udm.wr32(CSR_MATH_START, 1)
while(udm.rd(CSR_MATH_BUSY) == 0) 
    time.sleep(1)
res = udm.rdarr32(CSR_MATH_RES_ADDR, 4)
print("| " + str(res[0]) + " " + str(res[1]) + " |")
print("| " + str(res[2]) + " " + str(res[3]) + " |")

udm.disconnect()

