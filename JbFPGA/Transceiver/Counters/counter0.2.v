/*Добаывлен параметр для изменения
частоты PRESCALER - модуль деления

strb - сигнал новой частоты, появляющийся 
после её деления на модуль. Его будем
передавать на следующий счетчик(входом)
в программе передатчика для SPI*/
module presc #(
    parameter PRESCALER = 16                 // devision unit
)
(
input clk,
input rst,
output reg [3:0] Qount,			          // Counter output
output strb				                  // Counter overflow
);

assign strb = ( Qount == (PRESCALER - 1) ); // strb=0 just when Qount=0

always @(posedge clk)
begin
    if (rst)
    begin
        Qount <= 0;							// synchronous counter reset
    end 
	
    else
    begin    
        begin
            Qount <= Qount + 1;		       // counter launch(incrementing) 
        end

         if (strb)
        begin
            Qount <= 0;					 // the appearance of strobe
        end								// value of the divided frequency
	end
end	
endmodule