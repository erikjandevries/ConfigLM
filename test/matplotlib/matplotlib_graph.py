import matplotlib
print matplotlib.rcsetup.all_backends
matplotlib.use('GtkAgg')
import matplotlib.pyplot as plt
side = [0,1,2,3,4]
area = [0,1,4,9,16]
plt.plot(side,area)
plt.show()
