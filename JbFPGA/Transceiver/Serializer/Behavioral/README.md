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


 
Проверил работу Reset и Load. Они работают корректно(рис.3)  
```html
module piso #(parameter DATA_WIDTH = 9) 

(
    input rst_n, 
	input clk,
	input wire load,                           // Input signals	
	input [DATA_WIDTH-1:1] x,                  // Input parallel data
	
	output [DATA_WIDTH-1:1] y,                 // Triggers outputs, wich goes to the next trigger
    output z                                       // Serial output
);   
    reg [DATA_WIDTH-1:1] y;
    assign z= y[DATA_WIDTH-1];                     // Put the last trigger data to serial output
    integer i;                                     // Counting variable

always@(posedge clk)
begin
    if (rst_n == 1'b1)
    y<= {DATA_WIDTH{1'b0}};                        // Binary array of parallel inputs
    
    else
    if(load)
    begin
        for(i= 0; i< DATA_WIDTH; i= i+1)
        begin
            y[i+1]<= ((load && x[i+1]) || (~load && i)); //  y[4]<= ((load && x[4]) || (~load && y[3])); 
        end                                              // current trigger( y[4] ) gets previous trigger output( y[3] )    
    end     
end
endmodule
```

![ScreenShot](https://raw.githubusercontent.com/sht4nigga/FPGA/Assign_Reg/JbFPGA/Transceiver/Serializer/Behavioral/ex3.jpg) 
**Рисунок 3**

Но, увидев мой tb, сказали, что:  
**"Он отстой"!**  

test_bench код:  
```html
`timescale 1ns / 1ps
module piso_tb #(parameter DATA_WIDTH = 9);

        reg clk;
        reg rst_n;
        reg load;
        reg [DATA_WIDTH-1:1] x;            // Input parallel data
        
        wire [DATA_WIDTH-1:1] y;           // Triggers output data
        wire z;                            // Serial output
   
initial
begin
    clk = 1'b0;                            // Clk always LOW
    forever
    #10clk= ~clk;                          // Clk pulses 
end

initial
    $monitor ("x= %b, y= %b, z= %b", x, y, z);

initial
begin
    #0      rst_n = 1'b0;
            load = 1'b1;
            x  = {DATA_WIDTH{1'b0}};
       
    #3      rst_n = 1'b1;
    
    #2      x = {DATA_WIDTH{1'b1}};
    #20     rst_n = 1'b0;
    #40     load = 1'b0;
    #50     rst_n = 1'b1;
    #30     rst_n = 1'b0;
    //#120 $stop; 
end

piso inst1 (

    .rst_n(rst_n),
    .clk(clk),
    .load(load),
    .x(x),
    .y(y),
    .z(z)
);
endmodule
```  
  
  Остановился на том, что tb должен быть похож на tb для FIFO, со сменой clk и прочее.

