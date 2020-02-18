Это сериалайзер - преобразователь параллельного кода в последовательный, на основе сдвига регистра
с параллельным входом\последовательным выходом(PISO = parallel-input/serial-output).

Закончил на том, что переменные отображаются на диаргамме без неопределенных состояний. LOAD работает не верно:

**y[1]<= ((load && x[1]) || (~load && 1'b0));  
y[2]<= ((load && x[2]) || (~load && y[1]));   
y[3]<= ((load && x[3]) || (~load && y[2]));  
y[4]<= ((load && x[4]) || (~load && y[3]));**

LOAD постоянен при изменении сигнала reset  
![ScreenShot](https://raw.githubusercontent.com/sht4nigga/FPGA/Assign_Reg/JbFPGA/Transceiver/Serializer/Behavioral/Behavioral%20srlzr.jpg)
