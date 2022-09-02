import sys
import mountainCar
genomeNumber = int(sys.argv[1])
generation_number = int(sys.argv[2])
placeHolder = mountainCar.MainSim()
totalReward = placeHolder.mySimulate(genomeNumber,generation_number)
