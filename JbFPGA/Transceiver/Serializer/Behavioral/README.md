Это сериалайзер - преобразователь параллельного кода в последовательный, на основе сдвига регистра
с параллельным входом\последовательным выходом  **(PISO = parallel-input/serial-output)**

Закончил на том, что написал поведенческое описание serializer  со следующим кодом:

```html
module piso4_struc #(parameter DATA_WIDTH = 5) 
(
    input rst_n, 
	input clk,
	input wire load,                             // Input signals	
	input [4:1] x,                               // Input parallel data
	output [4:1] y,                              // Triggers outputs, wich goes to the next trigger
    	output z                                     // Serial output   
);
	reg [4:1] y;
	assign z= y[4];                              // Put the last trigger data to serial output

always@(negedge rst_n or posedge clk)
begin
    if (rst_n == 1'b0)
    y = 4'b0000;
    
    else
     y[1]<= ((load && x[1]) || (~load && 1'b0));
     y[2]<= ((load && x[2]) || (~load && y[1])); 
     y[3]<= ((load && x[3]) || (~load && y[2]));
     y[4]<= ((load && x[4]) || (~load && y[3]));    
end
endmodule

```  
Как видно из кода, тут асинхронный сброс(рис.1).

![ScreenShot](https://raw.githubusercontent.com/sht4nigga/FPGA/Assign_Reg/JbFPGA/Transceiver/Serializer/Behavioral/Behavioral%20srlzr.jpg)  
**Рисунок 1**

  
Если же делать с синхронным сбросом, то сдвига не происходит с текущим кодом(рис.2):  
```html
module piso4_struc #(parameter DATA_WIDTH = 5) 

(
    input rst_n, 
	input clk,
	input wire load,                             	// Input signals	
	input [DATA_WIDTH-1:1] x,                       // Input parallel data
	
	output [DATA_WIDTH-1:1] y,                      // Triggers outputs, wich goes to the next trigger
    output z                                            // Serial output
);   
    reg [DATA_WIDTH-1:1] y;
    assign z= y[DATA_WIDTH-1];                          // Put the last trigger data to serial output
    integer i;

always@(posedge clk)
begin
    if (rst_n)
    y<= 4'b0000;
    
    else
    if(load)
    begin
        for(i= 0; i< DATA_WIDTH; i= i+1)
        begin
            y[i+1]<= ((load && x[i+1]) || (~load && i));
        end
    end     
end
endmodule
```

![ScreenShot](https://raw.githubusercontent.com/sht4nigga/FPGA/Assign_Reg/JbFPGA/Transceiver/Serializer/Behavioral/Behavioral%20srlzr2.jpg)  
**Рисунок 2**

