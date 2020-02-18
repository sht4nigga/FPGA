Это сериалайзер - преобразователь параллельного кода в последовательный, на основе сдвига регистра
с параллельным входом\последовательным выходом(PISO = parallel-input/serial-output).


![ScreenShot](https://raw.githubusercontent.com/sht4nigga/FPGA/Assign_Reg/JbFPGA/Transceiver/Serializer/Functional/PISO.jpg)

Скрин взят из ролика очень прикольных индусов, умеющих объяснять доходчиво разные технические штуки.
https://www.youtube.com/watch?v=7LmBcGiiYwk

08.11.2019 16.51

Не получается сбрасывать сигналы shift, load и srl_out, при написании testBench
![ScreenShot](https://raw.githubusercontent.com/sht4nigga/FPGA/Assign_Reg/JbFPGA/Transceiver/Serializer/Functional/diag.jpg)

07.02.2020 14.58

Закончил на том, что переменные отображаются на диаргамме без неопределенных состояний. LOAD работает правильно.
![ScreenShot](https://raw.githubusercontent.com/sht4nigga/FPGA/Assign_Reg/JbFPGA/Transceiver/Serializer/Functional/work%20bitch.jpg)
