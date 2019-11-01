/*В этом счетчике кроме сброса
 и счета нет операций*/
module cnt1 (
    input clk,
    input rst,
    output reg [3:0] cnt
);

always @(posedge clk) 
begin
    if (rst) 
	begin
        cnt = 0;
    end 
	
	else 
	begin
        cnt <= cnt + 1;     
    end
end

endmodule